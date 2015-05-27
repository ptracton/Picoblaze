//                              -*- Mode: Verilog -*-
// Filename        : basic.v
// Description     : Basic Picoblaze Example Project
// Author          : Philip Tracton
// Created On      : Thu May 21 22:30:44 2015
// Last Modified By: Philip Tracton
// Last Modified On: Thu May 21 22:30:44 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

`timescale 1ns/1ns


module basic (/*AUTOARG*/
   // Inouts
   SWITCHES, LEDS,
   // Inputs
   CLK_IN, RESET_IN
   ) ;
   input CLK_IN;
   input RESET_IN;
   inout [7:0] SWITCHES;   
   inout [7:0] LEDS;
   
   //
   // Wires and Registers
   //

   wire [7:0] in_port;
   wire [7:0] LEDS;  
   wire [7:0] port_id;
   wire [7:0] out_port;
   wire [7:0] gpio_switches_data_out;
   wire [7:0] gpio_leds_data_out;
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 CLK_OUT;                // From syscon of system_controller.v
   wire                 RESET_OUT;              // From syscon of system_controller.v
   // End of automatics

   /*AUTOREG*/
   
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
//   assign CLK_OUT = CLK_IN;
//   assign RESET_OUT = RESET_IN;
   
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

   assign in_port = gpio_leds_data_out | gpio_switches_data_out;
   assign interrupt = gpio_switches_interrupt;
   assign kcpsm6_sleep = 0;   


   //
   // LED GPIO
   //
   pb_gpio gpio_leds(
                     // Outputs
                     .data_out(gpio_leds_data_out), 
                     .interrupt(gpio_leds_interrupt),
                     // Inouts
                     .gpio(LEDS),
                     // Inputs
                     .clk(CLK_OUT), 
                     .reset(RESET_OUT), 
                     .port_id(port_id), 
                     .data_in(out_port), 
                     .read_strobe(read_strobe), 
                     .write_strobe(write_strobe));
   
   
   //
   // Switches GPIO
   //
   
   pb_gpio #(.GPIO_BASE_ADDRESS(8))
   gpio_switches(
                 // Outputs
                 .data_out(gpio_switches_data_out), 
                 .interrupt(gpio_switches_interrupt),
                 // Inouts
                 .gpio(SWITCHES),
                 // Inputs
                 .clk(CLK_OUT), 
                 .reset(RESET_OUT), 
                 .port_id(port_id), 
                 .data_in(out_port), 
                 .read_strobe(read_strobe), 
                 .write_strobe(write_strobe));
   

   
   
endmodule // basic
