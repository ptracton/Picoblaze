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
     
   input [3:0]  segment0;
   input [3:0]  segment1;
   input [3:0]  segment2;
   input [3:0]  segment3;

   output [3:0] anode;
   output [7:0] cathode;
   
   //
   // Registers
   //
   reg [3:0]    anode   = 4'hF;
   reg [7:0]    cathode = 8'h00;

   //
   // Timer
   //
   // Assert timer_expired every milisecond.  This is when we switch
   // the ANODE and CATHODE values.
   //
   reg [31:0]   timer_count = 32'h0000_0000;
   wire         timer_expired = (timer_count == 32'd100000);
   
   always @(posedge clk)
     if (timer_expired) begin
        timer_count <= 32'h0000_0000;        
     end else begin
        timer_count <= timer_count + 1;        
     end

   //
   // Translation Function
   //
   // Take in 4 bit input and map to 8 bit output for use by
   // cathode for 7 segment display
   //
   function [7:0] map_segments;
      input [3:0] data_in;
      begin
         case (data_in)
           //                   8'bpGFEDCBA
           4'h0: map_segments = 8'b00111111;
           4'h1: map_segments = 8'b00000110;
           4'h2: map_segments = 8'b01011011;
           4'h3: map_segments = 8'b01001111;
           4'h4: map_segments = 8'b01100110;
           4'h5: map_segments = 8'b01101101;
           4'h6: map_segments = 8'b01111101;
           4'h7: map_segments = 8'b00000111;
           4'h8: map_segments = 8'b01111111;
           4'h9: map_segments = 8'b01100111;
           default map_segments = 8'b11111111;           
         endcase // case (data_in)
      end      
   endfunction // case   
   
   //
   // State Machine
   //
   reg [1:0] state      = 2'b00;
   reg [1:0] next_state = 2'b00;

   always @(posedge clk)
     state <= next_state;

   always @(*) begin
      case (state)
        2'b00 : begin
           anode = 4'b1110;
           cathode = map_segments(segment0);  
           next_state = (timer_expired) ? 2'b01: 2'b00;           
        end
        2'b01 : begin
           anode = 4'b1101;
           cathode = map_segments(segment1);
           next_state = (timer_expired) ? 2'b10: 2'b01;           
        end
        2'b10 : begin
           anode = 4'b1011;
           cathode = map_segments(segment2);
           next_state = (timer_expired) ? 2'b11: 2'b10;           
        end
        2'b11 : begin
           anode = 4'b0111;
           cathode = map_segments(segment3);
           next_state = (timer_expired) ? 2'b00: 2'b11;           
        end
      endcase // case (state)      
   end
     
   
endmodule // display
