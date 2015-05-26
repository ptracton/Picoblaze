`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2015 06:11:28 PM
// Design Name: 
// Module Name: system_controller
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


module system_controller(
                         input  CLK_IN,
                         input  RESET_IN,
                         output CLK_OUT,
                         output  RESET_OUT
                         );
   
   reg [4:0]                    reset_count = 4'h00;
   
   //
   // Input buffer to make sure the XCLK signal is routed
   // onto the low skew clock lines
   //
   wire                         xclk_buf;
   IBUFG xclk_ibufg(.I(CLK_IN), .O(xclk_buf));
   
   //
   // Using our input clk buffer, we sample the input reset
   // signal.  if it is high, we hold the count to 1 (NOT 0!)
   // Once the input reset is released, we will count until
   // we wrap around to 0.  While this counter is not 0,
   // assert the reset signal to all other blocks.  This is done
   // to ensure we get a good clean synchronous reset of all flops
   // in the device
   //
   // This is the ONLY place we use xclk_buf or XRESET!
   //
   wire                         LOCKED;
   //   assign dcm_reset = |reset_count;   
   assign RESET_OUT = !LOCKED || (|reset_count);
   always @(posedge xclk_buf)
     if (RESET_IN)
       reset_count <= 'h01;
     else
       if ( (|reset_count) & XREADY)
         reset_count <= reset_count +1;
   
   //
   // DCM Reset Logic.  This is also off the xclk_buf since
   // we want this to be synchronous and held for a few clocks
   // in order for the DCM to get a good reset.  
   //
   // This is the ONLY place we use xclk_buf or XRESET!
   //
   reg [3:0]                    dcm_reset_count = 4'h00;   
   assign dcm_reset = |dcm_reset_count;
   always @(posedge xclk_buf)
     if (RESET_IN)
       dcm_reset_count <= 'h01;
     else
       if (dcm_reset_count)
         dcm_reset_count <= dcm_reset_count + 1;     
   
   //   
   // Clock buffer that ensures the clock going out to the hardware is on a low skew line
   //
   assign XREADY = LOCKED;   
   BUFG clk_bug (
                 .O(CLK_OUT), // 1-bit output Clock buffer output
                 .I(CLKFBOUT) // 1-bit input Clock buffer input (S=0)
                 );

   // MMCME2_BASE: Base Mixed Mode Clock Manager
   //

   // Xilinx HDL Libraries Guide, version 14.2
   MMCME2_BASE #(
                 .BANDWIDTH("OPTIMIZED"),
                 // Jitter programming (OPTIMIZED, HIGH, LOW)
                 .CLKFBOUT_MULT_F(6.0),
                 // Multiply value for all CLKOUT (2.000-64.000).
                 .CLKFBOUT_PHASE(0.0),
                 // Phase offset in degrees of CLKFB (-360.000-360.000).
                 .CLKIN1_PERIOD(10.0),
                 // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
                 // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
                 .CLKOUT1_DIVIDE(1),
                 .CLKOUT2_DIVIDE(1),
                 .CLKOUT3_DIVIDE(1),
                 .CLKOUT4_DIVIDE(1),
                 .CLKOUT5_DIVIDE(1),
                 .CLKOUT6_DIVIDE(1),
                 .CLKOUT0_DIVIDE_F(1.0),
                 // Divide amount for CLKOUT0 (1.000-128.000).
                 // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
                 .CLKOUT0_DUTY_CYCLE(0.5),
                 .CLKOUT1_DUTY_CYCLE(0.5),
                 .CLKOUT2_DUTY_CYCLE(0.5),
                 .CLKOUT3_DUTY_CYCLE(0.5),
                 .CLKOUT4_DUTY_CYCLE(0.5),
                 .CLKOUT5_DUTY_CYCLE(0.5),
                 .CLKOUT6_DUTY_CYCLE(0.5),
                 // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
                 .CLKOUT0_PHASE(0.0),
                 .CLKOUT1_PHASE(0.0),
                 .CLKOUT2_PHASE(0.0),
                 .CLKOUT3_PHASE(0.0),
                 .CLKOUT4_PHASE(0.0),
                 .CLKOUT5_PHASE(0.0),
                 .CLKOUT6_PHASE(0.0),
                 .CLKOUT4_CASCADE("FALSE"), // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
                 .DIVCLK_DIVIDE(1),
                 // Master division value (1-106)
                 .REF_JITTER1(0.0),
                 // Reference input jitter in UI (0.000-0.999).
                 .STARTUP_WAIT("FALSE")
                 // Delays DONE until MMCM is locked (FALSE, TRUE)
                 )
   MMCME2_BASE_inst (
                     // Clock Outputs: 1-bit (each) output: User configurable clock outputs
                     .CLKOUT0(),
                     // 1-bit output: CLKOUT0
                     .CLKOUT0B(),
                     // 1-bit output: Inverted CLKOUT0
                     .CLKOUT1(),
                     // 1-bit output: CLKOUT1
                     .CLKOUT1B(),
                     // 1-bit output: Inverted CLKOUT1
                     .CLKOUT2(),
                     // 1-bit output: CLKOUT2
                     .CLKOUT2B(),
                     // 1-bit output: Inverted CLKOUT2
                     .CLKOUT3(),
                     // 1-bit output: CLKOUT3
                     .CLKOUT3B(),
                     // 1-bit output: Inverted CLKOUT3
                     .CLKOUT4(),
                     // 1-bit output: CLKOUT4
                     .CLKOUT5(),
                     // 1-bit output: CLKOUT5
                     .CLKOUT6(),
                     // 1-bit output: CLKOUT6
                     // Feedback Clocks: 1-bit (each) output: Clock feedback ports
                     .CLKFBOUT(CLKFBOUT),
                     // 1-bit output: Feedback clock
                     .CLKFBOUTB(), // 1-bit output: Inverted CLKFBOUT
                     // Status Ports: 1-bit (each) output: MMCM status ports
                     .LOCKED(LOCKED),
                     // 1-bit output: LOCK
                     // Clock Inputs: 1-bit (each) input: Clock input
                     .CLKIN1(xclk_buf),
                     // 1-bit input: Clock
                     // Control Ports: 1-bit (each) input: MMCM control ports
                     .PWRDWN(1'b0),
                     // 1-bit input: Power-down
                     .RST(dcm_reset),
                     // 1-bit input: Reset
                     // Feedback Clocks: 1-bit (each) input: Clock feedback ports
                     .CLKFBIN(CLK_OUT)
                     // 1-bit input: Feedback clock
                     );
   // End of MMCME2_BASE_inst instantiation
   

endmodule // system_control

/*
 // Template
 
 system_control sys_con(
 .XCLK(),
 .XRESET(),
 .XREADY(),
 .clk(),
 .reset()
 );
 */


