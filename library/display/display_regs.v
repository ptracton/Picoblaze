//                              -*- Mode: Verilog -*-
// Filename        : display_regs.v
// Description     : Seven Segment Display Registers
// Author          : Philip Tracton
// Created On      : Thu May 28 23:27:56 2015
// Last Modified By: Philip Tracton
// Last Modified On: Thu May 28 23:27:56 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module display_regs (/*AUTOARG*/
   // Outputs
   data_out, segment0, segment1, segment2, segment3,
   // Inputs
   clk, reset, port_id, data_in, read_strobe, write_strobe
   ) ;
   parameter BASE_ADDRESS = 8'h00;   
   
   input clk;
   input reset;
   
   input [7:0] port_id;
   input [7:0] data_in;
   output [7:0] data_out;
   input        read_strobe;
   input        write_strobe;

   output [7:0] segment0;
   output [7:0] segment1;
   output [7:0] segment2;
   output [7:0] segment3;
   
   
endmodule // display_regs
