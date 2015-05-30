# Picoblaze
Picoblaze projects on a Basys3

Set up for running JTAG_Loader

1. Install Vivado
2. Install ISE ( this is a problem!)
3. Configure the libraries and make sure the ISE ones are found first or there is a compatibility error.

export LD_LIBRARY_PATH=/opt/Xilinx/14.7/ISE_DS/ISE/lib/lin64:/opt/Xilinx/Vivado/2014.4/ids_lite/ISE/lib/lin64:/opt/Xilinx/Vivado/2014.4/lib/lnx64.o
sudo ldconfig

4. Now you can use JTAG Loader

