//                              -*- Mode: Verilog -*-
// Filename        : uart_regs.v
// Description     : UART Registers
// Author          : Philip Tracton
// Created On      : Wed May 27 17:22:20 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed May 27 17:22:20 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module pb_uart_regs (/*AUTOARG*/
   // Outputs
   data_out, interrupt, buffer_write, uart_data_write, buffer_read,
   enable, uart_clock_divide,
   // Inputs
   clk, reset, port_id, data_in, read_strobe, write_strobe,
   uart_data_read, rx_data_present, rx_half_full, rx_full,
   tx_data_present, tx_half_full, tx_full
   ) ;
   input clk;
   input reset;

   
   input [7:0] port_id;
   input [7:0] data_in;
   output [7:0] data_out;
   input        read_strobe;
   input        write_strobe;
   output       interrupt;
   
   output       buffer_write;
   output [7:0] uart_data_write;
   
   output       buffer_read;
   input [7:0]  uart_data_read;
   
   
   input        rx_data_present;
   input        rx_half_full;
   input        rx_full;

   input        tx_data_present;
   input        tx_half_full;
   input        tx_full;

   output       enable;
   output [15:0] uart_clock_divide;
   
   
   parameter BASE_ADDRESS = 8'h00;

 
   //
   // Address Decode
   //
   wire                   uart_data_in_enable  = (port_id == (BASE_ADDRESS + 0));  //Read Only
   wire                   uart_data_out_enable = (port_id == (BASE_ADDRESS + 0));  //Write Only
   wire                   uart_control_enable  = (port_id == (BASE_ADDRESS + 1));
   wire                   uart_status_enable   = (port_id == (BASE_ADDRESS + 2));
   wire                   uart_irq_mask_enable = (port_id == (BASE_ADDRESS + 3));
   wire                   uart_irq_enable      = (port_id == (BASE_ADDRESS + 4));
   wire                   uart_clock_divide_lower_enable = (port_id == (BASE_ADDRESS + 5));
   wire                   uart_clock_divide_upper_enable = (port_id == (BASE_ADDRESS + 6));
   
   //
   // Registers
   //
   reg [7:0]              uart_control         = 8'h00;
   reg [2:0]              uart_irq_mask        = 3'h00;
   reg [2:0]              uart_irq             = 3'h00; 
   reg [15:0]             uart_clock_divide    = 16'h0000;
   reg                    buffer_read          = 1'b0;
   reg                    buffer_write         = 1'b0;
   reg [7:0]              uart_data_write      = 8'h00;
   reg [7:0]              uart_data_read_reg   = 8'h00;
   reg [7:0]              data_out             = 8'h00;
   reg                    interrupt            = 1'b0;

   //
   // Interrupt Logic
   //
   always @(posedge clk)
     interrupt <= rx_data_present;
   
   //
   // Register Writing
   //
   always @(posedge clk)
     if (write_strobe == 1'b1) begin
        
        if (uart_data_in_enable) begin
           uart_data_write <= data_in;           
           buffer_write <= 1'b1;           
        end
        
        if (uart_control_enable) begin
           uart_control <= data_in;           
        end

        if (uart_irq_mask_enable) begin
           uart_irq_mask <= data_in[2:0];           
        end

        if (uart_clock_divide_lower_enable) begin
           uart_clock_divide[7:0] <= data_in;           
        end
        
        if (uart_clock_divide_upper_enable) begin
           uart_clock_divide[15:8] <= data_in;           
        end        

        
     end else begin
        buffer_write <= 1'b0;           
     end // else: !if(write_strobe == 1'b1)
   



   //
   // Register Reading
   //
   always @(posedge clk) begin

      if (uart_data_out_enable) begin
         data_out <= uart_data_read;         
         buffer_read <= 1'b1;           
      end 

      else if (uart_control_enable) begin
         data_out <= uart_control;           
      end

      else if (uart_status_enable) begin
         data_out <= {2'b00, tx_full, tx_half_full, tx_data_present, rx_full, rx_half_full, rx_data_present};           
      end
      
      else if (uart_irq_mask_enable) begin
         data_out <= {5'b0, uart_irq_mask};           
      end

      else if (uart_irq_enable) begin
         data_out <= {5'b0, uart_irq};           
      end
      
      else if (uart_clock_divide_lower_enable) begin
         data_out <= uart_clock_divide[7:0];           
      end
      
      else if (uart_clock_divide_upper_enable) begin
         data_out <= uart_clock_divide[15:8];           
      end  

      else begin
         data_out <= 8'h00;   
         buffer_read <= 1'b0;                 
      end
      
   end // always @ (posedge clk)   
   

     
endmodule // uart_regs
