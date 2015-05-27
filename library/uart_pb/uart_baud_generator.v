//                              -*- Mode: Verilog -*-
// Filename        : uart_baud_generator.v
// Description     : UART Baud Rate Generator
// Author          : Philip Tracton
// Created On      : Wed May 27 17:44:24 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed May 27 17:44:24 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module uart_baud_generator (/*AUTOARG*/
   // Outputs
   baud_rate,
   // Inputs
   clk, reset, clock_divide
   ) ;
   input clk;
   input reset;
   input enable;   
   input [15:0] clock_divide;
   output baud_rate;


   reg [15:0] count = 16'h0000;
   assign baud_rate = clock_divide == count;

   always @(posedge clk)
     if (enable) begin
        if (baud_rate) begin
           count <= 16'h0000;           
        end else begin
           count <= count + 1;           
        end
     end
   
endmodule // uart_baud_generator
