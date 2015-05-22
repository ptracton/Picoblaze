//                              -*- Mode: Verilog -*-
// Filename        : basic.v
// Description     : Basic Picoblaze Example Project
// Author          : Philip Tracton
// Created On      : Thu May 21 22:30:44 2015
// Last Modified By: Philip Tracton
// Last Modified On: Thu May 21 22:30:44 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module basic (/*AUTOARG*/
   // Inputs
   CLK_IN, RESET_IN
   ) ;
   input CLK_IN;
   input RESET_IN;

   //
   // Wires and Registers
   //
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 CLK_OUT;                // From syscon of system_controller.v
   wire                 RESET_OUT;              // From syscon of system_controller.v
   // End of automatics

   /*AUTOREG*/
   
   //
   // System Controller
   //
   system_controller syscon(/*AUTOINST*/
                            // Outputs
                            .CLK_OUT            (CLK_OUT),
                            .RESET_OUT          (RESET_OUT),
                            // Inputs
                            .CLK_IN             (CLK_IN),
                            .RESET_IN           (RESET_IN));
   
   
endmodule // basic
