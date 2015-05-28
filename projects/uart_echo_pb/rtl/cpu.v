//                              -*- Mode: Verilog -*-
// Filename        : cpu.v
// Description     : Complete Picoblaze Design
// Author          : Philip Tracton
// Created On      : Thu May 21 22:33:37 2015
// Last Modified By: Philip Tracton
// Last Modified On: Thu May 21 22:33:37 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

`timescale 1ns/1ns

module cpu (/*AUTOARG*/
   // Outputs
   port_id, out_port, write_strobe, read_strobe, interrupt_ack,
   // Inputs
   clk, in_port, interrupt, kcpsm6_sleep, cpu_reset
   ) ;

   input clk;
   input [7:0] in_port;
   output [7:0] port_id;
   output [7:0] out_port;
   output       write_strobe;
   output		read_strobe;   
   input        interrupt;            //See note above
   output		interrupt_ack;
   input        kcpsm6_sleep;
   input        cpu_reset;   
   
   /*AUTOWIRE*/
   /*AUTOREG*/

   
   //
   // Signals for connection of KCPSM6 and Program Memory.
   //
   wire	[11:0]	address;
   wire [17:0]  instruction;
   wire [7:0]   out_port;
   wire [7:0]   port_id;   
   wire			bram_enable;
   wire			k_write_strobe;
   wire			kcpsm6_reset;         //See note above

   wire         interrupt_ack;
   wire         read_strobe;
   wire         write_strobe;

   
   //
   // Some additional signals are required if your system also needs to reset KCPSM6. 
   //
   

   //
   // When interrupt is to be used then the recommended circuit included below requires 
   // the following signal to represent the request made from your system.
   //
   
   wire			int_request;
   
   kcpsm6 #(
	        .interrupt_vector	(12'h3FF),
	        .scratch_pad_memory_size(64),
	        .hwbuild		(8'h00))
   processor (
	          .address 		  (address),
	          .instruction 	  (instruction),
	          .bram_enable 	  (bram_enable),
	          .port_id 		  (port_id),
	          .write_strobe   (write_strobe),
	          .k_write_strobe (k_write_strobe),
	          .out_port 	  (out_port),
	          .read_strobe 	  (read_strobe),
	          .in_port 		  (in_port),
	          .interrupt 	  (interrupt),
	          .interrupt_ack  (interrupt_ack),
	          .reset 		  (kcpsm6_reset),
	          .sleep		  (kcpsm6_sleep),
	          .clk 			  (clk));

   //
   // If your design also needs to be able to reset KCPSM6 the arrangement below should be 
   // used to 'OR' your signal with 'rdl' from the program memory.
   // 
   
   uart_echo_pb_rom
     program_rom (    		       	//Name to match your PSM file
	                                .enable 		(bram_enable),
	                                .address 		(address),
	                                .instruction 	(instruction),
	                                .clk 			(clk));
   
  assign kcpsm6_reset = cpu_reset;

   
   
endmodule // cpu
