# Picoblaze
##Picoblaze projects on a Basys3

These projects were done to work out some ideas I had about Picoblaze.  The environement was designed and runs best on Linux.  I have not tried it on Windows.

The simulations can be run via a script, run_sim.py, in the tools directory.  It uses python3 and the [opbasm](https://kevinpt.github.io/opbasm/) Picoblaze assembler.  You may need to [install this, via pip](https://kevinpt.github.io/opbasm/#installation).  

An example:
Picoblaze/projects/uart_echo_pb/simulation $ ../../../tools/run_sim.py --json ../configuration/uart_echo_pb.json

The [JSON](http://www.w3schools.com/js/js_json_intro.asp) file tells the Python script which commands to run and which parameters to use.  This allows for a flexible design approach where a different configuraton file will run very differenlty.

The JTAG_Loader for re-programming the "ROM" does not work with Vivado!  I emailed Ken Chapman about this and he confirmed this was true.  You need to load the ISE 14.7 libraries before loading the Vivado libraries to use it.  

Set up for running JTAG_Loader

1. Install Vivado
2. Install ISE ( this is a problem!)
3. Configure the libraries and make sure the ISE ones are found first or there is a compatibility error.  The below is an example of this using the paths on my Linux PC.

export LD_LIBRARY_PATH=/opt/Xilinx/14.7/ISE_DS/ISE/lib/lin64:/opt/Xilinx/Vivado/2014.4/ids_lite/ISE/lib/lin64:/opt/Xilinx/Vivado/2015.2/lib/lnx64.o
sudo ldconfig

4. Now you can use JTAG Loader

