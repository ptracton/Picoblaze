////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2004 Xilinx, Inc.
// All Rights Reserved
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 1.02
//  \   \         Filename: ROM_form.v
//  /   /         Date Last Modified:  September 7 2004
// /___/   /\     Date Created: July 2003
// \   \  /  \
//  \___\/\___\
//
//Device:  	Xilinx
//Purpose: 	
//	This is the Verilog template file for the KCPSM3 assembler.
//	It is used to configure a Spartan-3, Virtex-II or Virtex-IIPRO block 
//	RAM to act as a single port program ROM.
//
//	This Verilog file is not valid as input directly into a synthesis or 
//	simulation tool.	The assembler will read this template and insert the 
//	data required to complete the definition of program ROM and write it out 
//	to a new '.v' file associated with the name of the original '.psm' file 
//	being assembled.
//
//	This template can be modified to define alternative memory definitions 
//	such as dual port.  However, you are responsible for ensuring the template
//	is correct as the assembler does not perform any checking of the Verilog.
//
//	The assembler identifies all text enclosed by {} characters, and replaces 
//	these character strings. All templates should include these {} character 
//	strings for the assembler to work correctly. 
//
//	This template defines a block RAM configured in 1024 x 18-bit single port 
//	mode and conneceted to act as a single port ROM.
//
//Reference:
// 	None
//Revision History:
//    Rev 1.00 - jc - Converted to verilog,  July 2003.
//    Rev 1.01 - sus - Added text to confirm to Xilinx HDL std,  August 4 2004.
//    Rev 1.02 - njs - Added attributes for Synplicity  August 5 2004.
//	Rev 1.03 - sus - Added text to conform to Xilinx generated 
//				HDL spec, September 7 2004
//
////////////////////////////////////////////////////////////////////////////////
// Contact: e-mail  picoblaze@xilinx.com
//////////////////////////////////////////////////////////////////////////////////
//
// Disclaimer: 
// LIMITED WARRANTY AND DISCLAIMER. These designs are
// provided to you "as is". Xilinx and its licensors make and you
// receive no warranties or conditions, express, implied,
// statutory or otherwise, and Xilinx specifically disclaims any
// implied warranties of merchantability, non-infringement, or
// fitness for a particular purpose. Xilinx does not warrant that
// the functions contained in these designs will meet your
// requirements, or that the operation of these designs will be
// uninterrupted or error free, or that defects in the Designs
// will be corrected. Furthermore, Xilinx does not warrant or
// make any representations regarding use or the results of the
// use of the designs in terms of correctness, accuracy,
// reliability, or otherwise.
//
// LIMITATION OF LIABILITY. In no event will Xilinx or its
// licensors be liable for any loss of data, lost profits, cost
// or procurement of substitute goods or services, or for any
// special, incidental, consequential, or indirect damages
// arising from the use or operation of the designs or
// accompanying documentation, however caused and on any theory
// of liability. This limitation will apply even if Xilinx
// has been advised of the possibility of such damage. This
// limitation shall apply not-withstanding the failure of the 
// essential purpose of any limited remedies herein. 
//////////////////////////////////////////////////////////////////////////////////

The next line is used to determine where the template actually starts and must exist.
{begin template}
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2004 Xilinx, Inc.
// All Rights Reserved
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: v1.30
//  \   \         Application : KCPSM3
//  /   /         Filename: {name}.v
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//Command: kcpsm3 {name}.psm
//Device: Spartan-3, Spartan-3E, Virtex-II, and Virtex-II Pro FPGAs
//Design Name: {name}
//Generated {timestamp}.
//Purpose:
//	{name} verilog program definition.
//
//Reference:
//	PicoBlaze 8-bit Embedded Microcontroller User Guide
////////////////////////////////////////////////////////////////////////////////

`timescale 100 ps / 10 ps

module {name} (address, instruction, clk);

input [9:0] address;
input clk;

output [17:0] instruction;

RAMB16_S18 ram_1024_x_18(
	.DI 	(16'h0000),
	.DIP 	(2'b00),
	.EN	(1'b1),
	.WE	(1'b0),
	.SSR	(1'b0),
	.CLK	(clk),
	.ADDR	(address),
	.DO	(instruction[15:0]),
			 .DOP	(instruction[17:16]));

// Attributes for Simulation
defparam ram_1024_x_18.INIT_00  = 256'h{INIT_00};
defparam ram_1024_x_18.INIT_01  = 256'h{INIT_01};
defparam ram_1024_x_18.INIT_02  = 256'h{INIT_02};
defparam ram_1024_x_18.INIT_03  = 256'h{INIT_03};
defparam ram_1024_x_18.INIT_04  = 256'h{INIT_04};
defparam ram_1024_x_18.INIT_05  = 256'h{INIT_05};
defparam ram_1024_x_18.INIT_06  = 256'h{INIT_06};
defparam ram_1024_x_18.INIT_07  = 256'h{INIT_07};
defparam ram_1024_x_18.INIT_08  = 256'h{INIT_08};
defparam ram_1024_x_18.INIT_09  = 256'h{INIT_09};
defparam ram_1024_x_18.INIT_0A  = 256'h{INIT_0A};
defparam ram_1024_x_18.INIT_0B  = 256'h{INIT_0B};
defparam ram_1024_x_18.INIT_0C  = 256'h{INIT_0C};
defparam ram_1024_x_18.INIT_0D  = 256'h{INIT_0D};
defparam ram_1024_x_18.INIT_0E  = 256'h{INIT_0E};
defparam ram_1024_x_18.INIT_0F  = 256'h{INIT_0F};
defparam ram_1024_x_18.INIT_10  = 256'h{INIT_10};
defparam ram_1024_x_18.INIT_11  = 256'h{INIT_11};
defparam ram_1024_x_18.INIT_12  = 256'h{INIT_12};
defparam ram_1024_x_18.INIT_13  = 256'h{INIT_13};
defparam ram_1024_x_18.INIT_14  = 256'h{INIT_14};
defparam ram_1024_x_18.INIT_15  = 256'h{INIT_15};
defparam ram_1024_x_18.INIT_16  = 256'h{INIT_16};
defparam ram_1024_x_18.INIT_17  = 256'h{INIT_17};
defparam ram_1024_x_18.INIT_18  = 256'h{INIT_18};
defparam ram_1024_x_18.INIT_19  = 256'h{INIT_19};
defparam ram_1024_x_18.INIT_1A  = 256'h{INIT_1A};
defparam ram_1024_x_18.INIT_1B  = 256'h{INIT_1B};
defparam ram_1024_x_18.INIT_1C  = 256'h{INIT_1C};
defparam ram_1024_x_18.INIT_1D  = 256'h{INIT_1D};
defparam ram_1024_x_18.INIT_1E  = 256'h{INIT_1E};
defparam ram_1024_x_18.INIT_1F  = 256'h{INIT_1F};
defparam ram_1024_x_18.INIT_20  = 256'h{INIT_20};
defparam ram_1024_x_18.INIT_21  = 256'h{INIT_21};
defparam ram_1024_x_18.INIT_22  = 256'h{INIT_22};
defparam ram_1024_x_18.INIT_23  = 256'h{INIT_23};
defparam ram_1024_x_18.INIT_24  = 256'h{INIT_24};
defparam ram_1024_x_18.INIT_25  = 256'h{INIT_25};
defparam ram_1024_x_18.INIT_26  = 256'h{INIT_26};
defparam ram_1024_x_18.INIT_27  = 256'h{INIT_27};
defparam ram_1024_x_18.INIT_28  = 256'h{INIT_28};
defparam ram_1024_x_18.INIT_29  = 256'h{INIT_29};
defparam ram_1024_x_18.INIT_2A  = 256'h{INIT_2A};
defparam ram_1024_x_18.INIT_2B  = 256'h{INIT_2B};
defparam ram_1024_x_18.INIT_2C  = 256'h{INIT_2C};
defparam ram_1024_x_18.INIT_2D  = 256'h{INIT_2D};
defparam ram_1024_x_18.INIT_2E  = 256'h{INIT_2E};
defparam ram_1024_x_18.INIT_2F  = 256'h{INIT_2F};
defparam ram_1024_x_18.INIT_30  = 256'h{INIT_30};
defparam ram_1024_x_18.INIT_31  = 256'h{INIT_31};
defparam ram_1024_x_18.INIT_32  = 256'h{INIT_32};
defparam ram_1024_x_18.INIT_33  = 256'h{INIT_33};
defparam ram_1024_x_18.INIT_34  = 256'h{INIT_34};
defparam ram_1024_x_18.INIT_35  = 256'h{INIT_35};
defparam ram_1024_x_18.INIT_36  = 256'h{INIT_36};
defparam ram_1024_x_18.INIT_37  = 256'h{INIT_37};
defparam ram_1024_x_18.INIT_38  = 256'h{INIT_38};
defparam ram_1024_x_18.INIT_39  = 256'h{INIT_39};
defparam ram_1024_x_18.INIT_3A  = 256'h{INIT_3A};
defparam ram_1024_x_18.INIT_3B  = 256'h{INIT_3B};
defparam ram_1024_x_18.INIT_3C  = 256'h{INIT_3C};
defparam ram_1024_x_18.INIT_3D  = 256'h{INIT_3D};
defparam ram_1024_x_18.INIT_3E  = 256'h{INIT_3E};
defparam ram_1024_x_18.INIT_3F  = 256'h{INIT_3F};
defparam ram_1024_x_18.INITP_00 = 256'h{INITP_00};
defparam ram_1024_x_18.INITP_01 = 256'h{INITP_01};
defparam ram_1024_x_18.INITP_02 = 256'h{INITP_02};
defparam ram_1024_x_18.INITP_03 = 256'h{INITP_03};
defparam ram_1024_x_18.INITP_04 = 256'h{INITP_04};
defparam ram_1024_x_18.INITP_05 = 256'h{INITP_05};
defparam ram_1024_x_18.INITP_06 = 256'h{INITP_06};
defparam ram_1024_x_18.INITP_07 = 256'h{INITP_07};


endmodule

// END OF FILE {name}.v