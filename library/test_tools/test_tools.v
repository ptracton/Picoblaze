//                              -*- Mode: Verilog -*-
// Filename        : test_tools.v
// Description     : Tools to help with test cases
// Author          : Philip Tracton
// Created On      : Wed May 27 21:11:18 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed May 27 21:11:18 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


module test_tools (/*AUTOARG*/ ) ;

   //
   // Registers
   //
   reg test_passed = 1'b0;
   reg test_failed = 1'b0;
   reg test_done = 1'b0;
   reg [31:0] test_fail_count = 32'h0000_0000;

   //
   // A test case can assert test_passed to signal a succesful
   // end to the test.  This will terminate the test.
   //
   always @(posedge test_passed) begin
      $display("Test Passed @ %d", $time);
      #100 $finish;           
   end

   //
   // A test case can assert test_failed to signal a failing
   // end to the test.  This will terminate the test.
   //
   always @(posedge test_failed) begin
      $display("Test Failed @ %d", $time);
      #100 $finish;           
   end

   //
   // A test case can assert test_done to signal to figure out
   // if the test case passed or failed and then terminate the simulation
   //
   always @(posedge test_done) begin
      if (test_fail_count) begin
         test_failed <= 1'b1;         
      end else begin
         test_passed <= 1'b1;         
      end
   end

   //
   // Task: test_case
   //
   // dstring -- String to $display to user
   // value -- the measured data
   // expected -- the expected data, if matches value then we passed, else fail
   //
   task test_case;
      input [32*8-1:0] dstring;
      input [31:0] value;
      input [31:0] expected;
      
      begin
         if (value !== expected) begin
            test_fail_count <= test_fail_count + 1;         
         end
         
         $display("%s\t\t0x%h\t\t0x%h\t\t", dstring, value,expected );
      end
      
   endtask // if
   
   
endmodule // test_tools
