//                              -*- Mode: Verilog -*-
// Filename        : pb_display.v
// Description     : Seven Segment Display
// Author          : Philip Tracton
// Created On      : Thu May 28 23:25:10 2015
// Last Modified By: Philip Tracton
// Last Modified On: Thu May 28 23:25:10 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module pb_display (/*AUTOARG*/
   // Outputs
   data_out, anode, cathode,
   // Inputs
   clk, reset, port_id, data_in, read_strobe, write_strobe
   ) ;

   parameter BASE_ADDRESS = 8'h00;
   
   input clk;
   input reset;

   input [7:0]            port_id;
   input [7:0]            data_in;
   output [7:0]           data_out;
   input                  read_strobe;
   input                  write_strobe;

   output [3:0]           anode;
   output [7:0]           cathode;
   
   
endmodule // pb_display
