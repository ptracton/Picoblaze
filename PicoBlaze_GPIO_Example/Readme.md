## Welcome Students!

This is the GPIO example project for Cem Unsalan and Bora Tar's book [Digital System Design with FPGA](https://www.amazon.com/dp/1259837904/).
This project has a Picoblaze CPU running firmware that will read the first 8 switches on a Basys 3 and turn on or off the corresponding LED on the board.

The basic.v file is the top level of the FPGA.  It is a container of the various components needed to make this design work.
The system_controller has the clocking and reset logic for this design.  The comments in this file that mention the DCM (digital clock module from older Xilinx parts) show that this approach has been used for a long time.  In this design the RESET_OUT = RESET_IN but this is actually not very good. Reset should be held until the locked signal from the MMCME2_BASE goes high, indicating the clock is ready and stable.
The Picoblaze CPU is our CPU that runs the firmware image from basic_rom.psm.

The 2 pb_gpio instances are showing code re-use.  A single general purpose block for handling either catching the switches being asserted or turning on the LEDs.  The switches instance shows how to change the address of the registers so the blocks can be addressed separately.  Inside of pb_gpio are 2 more modules, demonstrating design hierarchy.  The gpio_regs instance handles the Picoblaze bus interface and reading/writing to the firmware addressable registers.  The gpio instance contains 8 iNstances of gpio_bit.  The gpio_bit handles 1 bit of bi-directional logic.
