//                              -*- Mode: Verilog -*-
// Filename        : display.v
// Description     : Seven Segment Display Driver
// Author          : Philip Tracton
// Created On      : Thu May 28 23:29:58 2015
// Last Modified By: Philip Tracton
// Last Modified On: Thu May 28 23:29:58 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module display (/*AUTOARG*/
   // Outputs
   anode, cathode,
   // Inputs
   clk, segment0, segment1, segment2, segment3
   ) ;
   input clk;
   input switch;   
   input [7:0] segment0;
   input [7:0] segment1;
   input [7:0] segment2;
   input [7:0] segment3;

   output [3:0] anode;
   output [7:0] cathode;
   
   
endmodule // display
