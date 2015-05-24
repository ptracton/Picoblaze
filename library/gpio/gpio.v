//                              -*- Mode: Verilog -*-
// Filename        : gpio.v
// Description     : GPIO byte
// Author          : Philip Tracton
// Created On      : Sat May 23 23:07:14 2015
// Last Modified By: Philip Tracton
// Last Modified On: Sat May 23 23:07:14 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module gpio (/*AUTOARG*/
   // Outputs
   gpio_data_in,
   // Inouts
   gpio,
   // Inputs
   clk, gpio_oen, gpio_data_out
   ) ;

   
   input clk;
   input [7:0] gpio_oen;
   output [7:0] gpio_data_in;   //from GPIO to CPU
   input [7:0]  gpio_data_out;  //From CPU to GPIO
    
   inout [7:0] gpio;

   //
   // Instantiate 8 bits of GPIO
   //
   
   gpio_bit bit0(
                 // Outputs
                 .gpio_data_in          (gpio_data_in[0]),
                 // Inouts
                 .gpio                  (gpio[0]),
                 // Inputs
                 .clk                   (clk),
                 .gpio_oen              (gpio_oen[0]),
                 .gpio_data_out         (gpio_data_out[0]));

   gpio_bit bit1(
                 // Outputs
                 .gpio_data_in          (gpio_data_in[1]),
                 // Inouts
                 .gpio                  (gpio[1]),
                 // Inputs
                 .clk                   (clk),
                 .gpio_oen              (gpio_oen[1]),
                 .gpio_data_out         (gpio_data_out[1]));

   gpio_bit bit2(
                 // Outputs
                 .gpio_data_in          (gpio_data_in[2]),
                 // Inouts
                 .gpio                  (gpio[2]),
                 // Inputs
                 .clk                   (clk),
                 .gpio_oen              (gpio_oen[2]),
                 .gpio_data_out         (gpio_data_out[2]));

   gpio_bit bit3(
                 // Outputs
                 .gpio_data_in          (gpio_data_in[3]),
                 // Inouts
                 .gpio                  (gpio[3]),
                 // Inputs
                 .clk                   (clk),
                 .gpio_oen              (gpio_oen[3]),
                 .gpio_data_out         (gpio_data_out[3]));

   gpio_bit bit4(
                 // Outputs
                 .gpio_data_in          (gpio_data_in[4]),
                 // Inouts
                 .gpio                  (gpio[4]),
                 // Inputs
                 .clk                   (clk),
                 .gpio_oen              (gpio_oen[4]),
                 .gpio_data_out         (gpio_data_out[4]));

   gpio_bit bit5(
                 // Outputs
                 .gpio_data_in          (gpio_data_in[5]),
                 // Inouts
                 .gpio                  (gpio[5]),
                 // Inputs
                 .clk                   (clk),
                 .gpio_oen              (gpio_oen[5]),
                 .gpio_data_out         (gpio_data_out[5]));

   gpio_bit bit6(
                 // Outputs
                 .gpio_data_in          (gpio_data_in[6]),
                 // Inouts
                 .gpio                  (gpio[6]),
                 // Inputs
                 .clk                   (clk),
                 .gpio_oen              (gpio_oen[6]),
                 .gpio_data_out         (gpio_data_out[6]));  

   gpio_bit bit7(
                 // Outputs
                 .gpio_data_in          (gpio_data_in[7]),
                 // Inouts
                 .gpio                  (gpio[7]),
                 // Inputs
                 .clk                   (clk),
                 .gpio_oen              (gpio_oen[7]),
                 .gpio_data_out         (gpio_data_out[7]));   
   
   
endmodule // gpio
