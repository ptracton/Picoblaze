//                              -*- Mode: Verilog -*-
// Filename        : pb_gpio.v
// Description     : Picoblaze GPIO
// Author          : Philip Tracton
// Created On      : Sat May 23 22:49:19 2015
// Last Modified By: Philip Tracton
// Last Modified On: Sat May 23 22:49:19 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


module pb_gpio (/*AUTOARG*/
   // Outputs
   data_out, interrupt,
   // Inouts
   gpio,
   // Inputs
   clk, reset, port_id, data_in, read_strobe, write_strobe
   ) ;

   parameter GPIO_WIDTH = 8;
   parameter GPIO_BASE_ADDRESS = 8'h00;
   
   input clk;
   input reset;

   inout [7:0] gpio;

   input [7:0]            port_id;
   input [7:0]            data_in;
   output [7:0]           data_out;
   input                  read_strobe;
   input                  write_strobe;
   output                 interrupt;

   wire [7:0]             gpio_oen;
   wire [7:0]             gpio_data_in;
   wire [7:0]             gpio_data_out;
   
   gpio_regs #(.GPIO_BASE_ADDRESS(GPIO_BASE_ADDRESS))
   regs(/*AUTOINST*/
        // Outputs
        .data_out                       (data_out[7:0]),
        .gpio_oen                       (gpio_oen[7:0]),
        .gpio_data_out                  (gpio_data_out[7:0]),
        .interrupt                      (interrupt),
        // Inputs
        .clk                            (clk),
        .reset                          (reset),
        .port_id                        (port_id[7:0]),
        .data_in                        (data_in[7:0]),
        .read_strobe                    (read_strobe),
        .write_strobe                   (write_strobe),
        .gpio_data_in                   (gpio_data_in[7:0]));

   gpio port(/*AUTOINST*/
             // Outputs
             .gpio_data_in              (gpio_data_in[7:0]),
             // Inouts
             .gpio                      (gpio[GPIO_WIDTH-1:0]),
             // Inputs
             .clk                       (clk),
             .gpio_oen                  (gpio_oen[7:0]),
             .gpio_data_out             (gpio_data_out[7:0]));
   
   
endmodule // pb_gpio
