//                              -*- Mode: Verilog -*-
// Filename        : gpio_regs.v
// Description     : Picoblaze GPIO Register Interface
// Author          : Philip Tracton
// Created On      : Sat May 23 22:52:12 2015
// Last Modified By: Philip Tracton
// Last Modified On: Sat May 23 22:52:12 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


module gpio_regs (/*AUTOARG*/
   // Outputs
   data_out, gpio_oen, gpio_data_out, interrupt,
   // Inputs
   clk, reset, port_id, data_in, read_strobe, write_strobe,
   gpio_data_in
   ) ;

   parameter GPIO_BASE_ADDRESS = 8'h00;   
   
   input clk;
   input reset;

   input [7:0]            port_id;
   input [7:0]            data_in;
   output [7:0]           data_out;
   input                  read_strobe;
   input                  write_strobe;   

   output [7:0]           gpio_oen;
   output [7:0]           gpio_data_out;
   input [7:0]            gpio_data_in;

   output                 interrupt;

   reg                    interrupt  = 0;
   reg [7:0]              data_out   = 8'h00; 
   
   
   reg [7:0]              gpio_oen      = 8'h00;
   reg [7:0]              gpio_data_out = 8'h00;
   reg [7:0]              gpio_control  = 8'h00;
   reg [7:0]              gpio_irq_mask = 8'hFF;
   reg [7:0]              gpio_irq      = 8'h00;
   
   
   //
   // Address Decode
   //
   wire                   gpio_oen_enable      = (port_id == (GPIO_BASE_ADDRESS + 0));
   wire                   gpio_data_in_enable  = (port_id == (GPIO_BASE_ADDRESS + 1));  //Read Only
   wire                   gpio_data_out_enable = (port_id == (GPIO_BASE_ADDRESS + 1));  //Write Only
   wire                   gpio_control_enable  = (port_id == (GPIO_BASE_ADDRESS + 2));
   wire                   gpio_irq_mask_enable = (port_id == (GPIO_BASE_ADDRESS + 3));
   wire                   gpio_irq_enable      = (port_id == (GPIO_BASE_ADDRESS + 4));
   

   //
   // GPIO Edge Change detection
   //
   reg [7:0]              gpio_data_in_previous = 1'b0;
   wire [7:0]             gpio_edge_detection = gpio_data_in_previous ^ gpio_data_in;
   always @(posedge clk) begin
      gpio_data_in_previous <= gpio_data_in;      
   end
         
   //
   // If a positive edge is happening, capture it as a possible interrupt
   // Must write a 1 to the bit to clear it
   //
   always @(posedge clk)
     if (gpio_edge_detection) begin
        gpio_irq <= gpio_edge_detection;        
     end else if (write_strobe & gpio_irq_enable) begin
        gpio_irq <= gpio_irq & ~data_in;        
     end
   
   //
   // Interrupt logic -- capture positive edge and mask bit is clear
   //

   always @(posedge clk)
     if (gpio_irq & ~gpio_irq_mask) begin
        interrupt <= 1'b1;        
     end else begin
        interrupt <= 1'b0;        
     end
   
   //
   // Register Writing
   //
   always @(posedge clk)
     if (write_strobe == 1'b1) begin
        if (gpio_oen_enable) begin
           gpio_oen <= data_in;           
        end

        if (gpio_data_out_enable) begin
           gpio_data_out <= data_in;           
        end

        if (gpio_control_enable) begin
           gpio_control <= data_in;           
        end        

        if (gpio_irq_mask_enable) begin
           gpio_irq_mask <= data_in;           
        end 
        
     end

   //
   // Register Reading
   //
   always @(posedge clk) begin

//      if (read_strobe) begin
         
         if (gpio_oen_enable) begin
            data_out <= gpio_oen;           
         end
         
         else if (gpio_data_out_enable) begin
            data_out <= gpio_data_in;           
         end
         
         else if (gpio_control_enable) begin
            data_out <= gpio_control;           
         end

         else if (gpio_irq_mask_enable) begin
            data_out <= gpio_irq_mask;           
         end
         
         else if (gpio_irq_enable) begin
            data_out <= gpio_irq;           
         end
         
         else begin
            data_out <= 8'h00;            
         end
         
//      end // if (read_strobe)
   end // always @ (posedge clk)

 
   
endmodule // gpio_regs
