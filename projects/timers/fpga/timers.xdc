## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK_IN]							
set_property IOSTANDARD LVCMOS33 [get_ports CLK_IN]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK_IN]
 
##Buttons
set_property PACKAGE_PIN U18 [get_ports RESET_IN]						
set_property IOSTANDARD LVCMOS33 [get_ports RESET_IN]

 
##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports RX]						
set_property IOSTANDARD LVCMOS33 [get_ports RX]

set_property PACKAGE_PIN A18 [get_ports TX]						
set_property IOSTANDARD LVCMOS33 [get_ports TX]


##7 segment display
set_property PACKAGE_PIN W7 [get_ports {CATHODE[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {CATHODE[0]}]
set_property PACKAGE_PIN W6 [get_ports {CATHODE[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {CATHODE[1]}]
set_property PACKAGE_PIN U8 [get_ports {CATHODE[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {CATHODE[2]}]
set_property PACKAGE_PIN V8 [get_ports {CATHODE[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {CATHODE[3]}]
set_property PACKAGE_PIN U5 [get_ports {CATHODE[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {CATHODE[4]}]
set_property PACKAGE_PIN V5 [get_ports {CATHODE[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {CATHODE[5]}]
set_property PACKAGE_PIN U7 [get_ports {CATHODE[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {CATHODE[6]}]
set_property PACKAGE_PIN V7 [get_ports CATHODE[7]]							
set_property IOSTANDARD LVCMOS33 [get_ports CATHODE[7]]

set_property PACKAGE_PIN U2 [get_ports {ANODE[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {ANODE[0]}]
set_property PACKAGE_PIN U4 [get_ports {ANODE[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {ANODE[1]}]
set_property PACKAGE_PIN V4 [get_ports {ANODE[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {ANODE[2]}]
set_property PACKAGE_PIN W4 [get_ports {ANODE[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {ANODE[3]}]
