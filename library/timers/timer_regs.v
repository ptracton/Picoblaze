//                              -*- Mode: Verilog -*-
// Filename        : timer_regs.v
// Description     : PIcoblze Timer Registers
// Author          : Philip Tracton
// Created On      : Thu May 28 22:26:51 2015
// Last Modified By: Philip Tracton
// Last Modified On: Thu May 28 22:26:51 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module timer_regs (/*AUTOARG*/
   // Outputs
   data_out, interrupt,
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
   
   output       interrupt;
   output       timer_enable;
   output       timer_one_shot;
   output [31:0] timer_count;
   output        timer_interrupt_clear;   
   input         timer_interrupt;

      
   //
   // Registers
   //
   reg           interrupt      = 0;
   reg [7:0]     data_out       = 8'h00;
   reg [7:0]     timer_control  = 8'h00;
   reg [7:0]     timer_status   = 8'h00;
   reg           timer_irq_mask = 1'b0;
   reg [31:0]    timer_count    = 32'h0000_0000;

   //
   // Wires
   //
   wire          timer_enable    = timer_control[0];
   wire          timer_one_shot  = timer_control[1];
   wire          timer_interrupt_enable = timer_control[2];
   wire          timer_interrupt_clear = timer_control[3];
   
   //
   // Interrupt Logic
   //
   always @(posedge clk)
     if (timer_interrupt_enable & !timer_interrupt_clear) begin
        interrupt <= ~timer_irq_mask & timer_interrupt;        
     end else begin
        interrupt <= 1'b0;        
     end
   
   //
   // Address Decode
   //
   wire          timer_control_enable  = (port_id == (BASE_ADDRESS + 0));
   wire          timer_status_enable   = (port_id == (BASE_ADDRESS + 1));
   wire          timer_irq_mask_enable = (port_id == (BASE_ADDRESS + 2));
   wire          timer_count0_enable   = (port_id == (BASE_ADDRESS + 3));
   wire          timer_count1_enable   = (port_id == (BASE_ADDRESS + 4));
   wire          timer_count2_enable   = (port_id == (BASE_ADDRESS + 5));
   wire          timer_count3_enable   = (port_id == (BASE_ADDRESS + 6));
   
   //
   // Write Logic
   //
   always @(posedge clk)
     if (write_strobe) begin
        
        if (timer_control_enable) begin
           timer_control <= data_in;           
        end
        
        if (timer_irq_mask_enable) begin
           timer_irq_mask <= data_in[0];           
        end

        if (timer_count0_enable) begin
           timer_count[7:0] <= data_in;           
        end

        if (timer_count1_enable) begin
           timer_count[15:8] <= data_in;           
        end

        if (timer_count2_enable) begin
           timer_count[23:16] <= data_in;           
        end

        if (timer_count3_enable) begin
           timer_count[31:24] <= data_in;           
        end         
     end // if (write_strobe)

   //
   // Read Logic
   //
   always @(posedge clk) begin
      if (timer_control_enable) begin
         data_out <= timer_control;         
      end

      else if (timer_status_enable) begin
         data_out <= {7'b0000000, interrupt};         
      end

      else if (timer_irq_mask_enable) begin
         data_out <= {7'b0000000, timer_irq_mask};         
      end

      else begin
         data_out <= 8'h00;         
      end
      
   end
   
endmodule // timer_regs
