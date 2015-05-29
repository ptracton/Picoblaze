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

   //
   // Registers
   //
   reg [3:0]    segment0 = 4'h0;
   reg [3:0]    segment1 = 4'h0;
   reg [3:0]    segment2 = 4'h0;
   reg [3:0]    segment3 = 4'h0;   
   reg [7:0]    data_out = 8'h00;
   
   //
   // Address Decode
   //
   wire         segment0_enable = (port_id == (BASE_ADDRESS + 0));
   wire         segment1_enable = (port_id == (BASE_ADDRESS + 1));
   wire         segment2_enable = (port_id == (BASE_ADDRESS + 2));
   wire         segment3_enable = (port_id == (BASE_ADDRESS + 3));
   
   //
   // Write Logic
   //
   always @(posedge clk)
     if (write_strobe) begin
        if (segment0_enable) begin
           segment0 <= data_in;           
        end
        if (segment1_enable) begin
           segment1 <= data_in;           
        end
        if (segment2_enable) begin
           segment2 <= data_in;           
        end
        if (segment3_enable) begin
           segment3 <= data_in;           
        end        
     end // if (write_strobe)

   //
   // Read Logic
   //
   always @(posedge clk) begin

      if (segment0_enable) begin
         data_out[3:0] <= segment0[3:0];           
      end
      else if (segment1_enable) begin
         data_out[3:0] <= segment1[3:0];           
      end
      else if (segment2_enable) begin
         data_out[3:0] <= segment2[3:0];           
      end
      else if (segment3_enable) begin
         data_out[3:0] <= segment3[3:0];           
      end 
      else begin
         data_out <= 8'h00;         
      end
   end // always @ (posedge clk)   
   
   
   
endmodule // display_regs
