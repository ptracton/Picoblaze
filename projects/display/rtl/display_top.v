//                              -*- Mode: Verilog -*-
// Filename        : display_top.v
// Description     : Display numbers from UART to 7 Segments
// Author          : Philip Tracton
// Created On      : Wed May 27 17:15:49 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed May 27 17:15:49 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module display_top (/*AUTOARG*/
   // Outputs
   TX, ANODE, CATHODE,
   // Inputs
   CLK_IN, RESET_IN, RX
   ) ;
   input CLK_IN;
   input RESET_IN;
   input RX;
   output TX;
   
   output [3:0] ANODE;
   output [7:0] CATHODE;
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 CLK_OUT;                // From syscon of system_controller.v
   wire                 RESET_OUT;              // From syscon of system_controller.v
   // End of automatics
   /*AUTOREG*/

   wire                 TX;
   wire [7:0]           port_id;
   wire [7:0]           out_port;
   wire [7:0]           in_port;
   wire [7:0]           uart_data_out;
   wire [7:0]           display_data_out;
   wire [3:0]           ANODE;
   wire [7:0]           CATHODE;

      
   //
   // System Controller
   //
   system_controller syscon(/*AUTOINST*/
                            // Outputs
                            .CLK_OUT            (CLK_OUT),
                            .RESET_OUT          (RESET_OUT),
                            // Inputs
                            .CLK_IN             (CLK_IN),
                            .RESET_IN           (RESET_IN));
   

   //
   // Picoblaze CPU
   //
   cpu Picoblaze(
                 // Outputs
                 .port_id               (port_id[7:0]),
                 .out_port              (out_port[7:0]),
                 .write_strobe          (write_strobe),
                 .read_strobe           (read_strobe),
                 .interrupt_ack         (interrupt_ack),
                 // Inputs
                 .clk                   (CLK_OUT),
                 .in_port               (in_port[7:0]),
                 .interrupt             (interrupt),
                 .kcpsm6_sleep          (kcpsm6_sleep),
                 .cpu_reset             (RESET_OUT));

   assign in_port =  uart_data_out | display_data_out;
   assign interrupt = uart_irq;
   assign kcpsm6_sleep = 0;   

   //
   // UART
   //
   pb_uart uart(
                // Outputs
                .TX(TX), 
                .data_out(uart_data_out), 
                .interrupt(uart_irq),
                // Inputs
                .clk(CLK_OUT), 
                .reset(RESET_OUT), 
                .RX(RX), 
                .port_id(port_id), 
                .data_in(out_port), 
                .read_strobe(read_strobe), 
                .write_strobe(write_strobe)
                ) ;
   
   //
   // Display
   //
   pb_display #(.BASE_ADDRESS(8'h10))
     seven_segments(
                             // Outputs
                             .data_out(display_data_out), 
                             .anode(ANODE), 
                             .cathode(CATHODE),
                             // Inputs
                             .clk(CLK_OUT), 
                             .reset(RESET_OUT), 
                             .port_id(port_id), 
                             .data_in(out_port), 
                             .read_strobe(read_strobe), 
                             .write_strobe(write_strobe)
                             ) ;   
   
endmodule // uart_echo_pb
