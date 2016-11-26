`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2016 07:00:27 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;

   //
   // Model the free running clock on the Basys 3 bpard
   //
   reg clk;
   initial begin
      clk <= 1'b0;
      forever
        #5 clk <= ~clk;      
   end

   //
   // Model the reset as the center button on the Basys 3 board
   //
   reg reset;
   initial begin
      reset <= 1'b0;
      #13 reset <= 1'b1;
      #57 reset <= 1'b0;      
   end

   //
   // Models of LEDs and Swotches on the Basys 3 board
   //
   reg [7:0] switches_reg =0;   
   wire [7:0] switches;
   wire [7:0] leds;

   assign switches = switches_reg;
      
    basic dut(/*AUTOARG*/
              // Inouts
              .SWITCHES(switches), 
              .LEDS(leds),
              // Inputs
              .CLK_IN(clk), 
              .RESET_IN(reset)
              ) ;

   //
   // Test Case Tools
   //
   reg         test_passed = 0;
   reg         test_failed = 0;
   integer     i;
   
   //
   // If test fails, alert user and terminate simulation
   //
   always @(posedge test_failed) begin
      $display("Test Failed @ %d" % $time);
      #10 $finish;             
   end

   //
   // If test passes, alert user and terminate simulation
   //
   always @(posedge test_passed) begin
      $display("TEST PASSED @ %d", $time);
      #10 $finish;      
   end

   //
   // Time out issues, if our test does not complete in time, fail it
   //
   initial begin
      #100_000;
      $display("TEST CASE TIMED OUT ");
      test_failed <= 1;      
   end
   
   //
   // Run our test case!
   //
   initial begin
      //
      // Wait for reset to finish before starting test case
      //
      @(posedge reset);
      repeat (10) @(posedge clk);
      for (i=0; i<8; i=i+1) begin
         switches_reg[i] <= (1 << i);  //Flip switch up
         @(posedge leds[i]);       //Wait for corresponding LED to light up         
      end

      
      repeat (10) @(posedge clk);
      switches_reg <= 8'hFF;
      
      repeat (10) @(posedge clk);
      for (i=0; i<8; i=i+1) begin
         switches_reg[i] <= (0 << i);  //Flip switch down
         @(negedge leds[i]);       //Wait for corresponding LED to turn off
      end
      
      test_passed <= 1;
      
   end
endmodule
