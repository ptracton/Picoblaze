//                              -*- Mode: Verilog -*-
// Filename        : gpio_bit.v
// Description     : A single GPIO bit
// Author          : Philip Tracton
// Created On      : Sat May 23 23:15:07 2015
// Last Modified By: Philip Tracton
// Last Modified On: Sat May 23 23:15:07 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module gpio_bit (/*AUTOARG*/
   // Outputs
   gpio_data_in,
   // Inouts
   gpio,
   // Inputs
   clk, gpio_oen, gpio_data_out
   ) ;

   input clk;           

   input gpio_oen;
   input gpio_data_out;
   output gpio_data_in;

   inout  gpio;
   
   reg    gpio_data_in;

   //
   // If gpio_oen (Output ENable) is high, drive the
   // GPIO pin with the data from the CPU
   //
   assign gpio = (gpio_oen) ? gpio_data_out : 1'bz;

   //
   // If gpio_oen (Output ENable) is low, sample the input
   // from the GPIO on every clock edge and send back to CPU
   //
   always @(posedge clk)
     if (!gpio_oen) begin
        gpio_data_in <= gpio;        
     end
   
endmodule // gpio_bit
