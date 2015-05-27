//                              -*- Mode: Verilog -*-
// Filename        : testbench.v
// Description     : Basic Picoblaze TB
// Author          : Philip Tracton
// Created On      : Thu May 21 22:35:48 2015
// Last Modified By: Philip Tracton
// Last Modified On: Thu May 21 22:35:48 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

`timescale 1ns/1ns

module testbench (/*AUTOARG*/) ;

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)

   // End of automatics
   /*AUTOREG*/
 
   //
   // Free Running 100 MHz clock
   //
   reg CLK_IN = 0;
   initial begin
      forever begin
         #5 CLK_IN <= ~CLK_IN;         
      end
   end

   //
   // Reset
   //
   reg RESET_IN = 0;
   initial begin
      #100 RESET_IN <= 1;
      #1000 RESET_IN <= 0;      
   end

   wire [7:0]           LEDS;                   // From dut of basic.v
   reg [7:0]            SWITCHES_reg = 8'h00;                   // From dut of basic.v
   wire [7:0]           SWITCHES;
   assign SWITCHES = SWITCHES_reg;
   
   basic dut(/*AUTOINST*/
             // Outputs
             .LEDS                      (LEDS[7:0]),
             // Inputs
             .CLK_IN                    (CLK_IN),
             .RESET_IN                  (RESET_IN),
             .SWITCHES                  (SWITCHES[7:0]));
   

   //
   // Test XCase
   //
   initial begin
      @(posedge RESET_IN);
      $display("RESET: Asserted @ %d", $time);
      @(negedge RESET_IN);
      $display("RESET: De-Asserted @ %d", $time);

//      @(posedge testbench.dut.syscon.LOCKED);
//      $display("DCM LOCKED @ %d", $time);

      @(posedge LEDS[7]);
      $display("LEDS ON @ %d", $time);


      repeat(100) @(posedge CLK_IN);      
      SWITCHES_reg <= 8'hFF;
      $display("SWITCHES ASSERTED @ %d", $time);
      
      
      @(posedge (LEDS == 8'hFF));
      $display("SWITCHES to LEDS FF @ %d", $time);

      SWITCHES_reg <= 8'h00;
      @(posedge (LEDS == 8'h00));
      $display("SWITCHES to LEDS 00 @ %d", $time);

      SWITCHES_reg <= 8'hFF;
      @(posedge (LEDS == 8'hFF));
      $display("SWITCHES to LEDS FF @ %d", $time);
      
      repeat(100) @(posedge CLK_IN);      
      $stop;
      
   end
endmodule // Basic
