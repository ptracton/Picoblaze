//                              -*- Mode: Verilog -*-
// Filename        : uart_echo_pb.v
// Description     : UART Echo with Picoblaze and UART that came with it
// Author          : Philip Tracton
// Created On      : Wed May 27 17:15:49 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed May 27 17:15:49 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module uart_echo_pb (/*AUTOARG*/
   // Outputs
   TX,
   // Inputs
   CLK_IN, RESET_IN, RX
   ) ;
   input CLK_IN;
   input RESET_IN;
   input RX;
   output TX;

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 CLK_OUT;                // From syscon of system_controller.v
   wire                 RESET_OUT;              // From syscon of system_controller.v
   // End of automatics
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  TX;
   // End of automatics

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

   assign in_port =  uart_data_out;
   assign interrupt = uart_irq;
   assign kcpsm6_sleep = 0;   

   
endmodule // uart_echo_pb
