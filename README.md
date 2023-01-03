# conway-accelerator
Simple computing kernel for coway's game of life to be ported to Accelerator Rich Overlay.

                      Module Hierarchy

Top level:      conway_top.sv -> (onway_hwpe_tb.vhd)

Designe Level:  conway.vhd

Module level: conway_adder.vhd, conway_line_block.vhd

Component :                           dff.vhd   
             

             
         
 Design Schematic:
                               
![conway_design_02 drawio](https://user-images.githubusercontent.com/115657455/210360671-9d6381f0-e6a5-43bd-8217-7589bcad6022.png)


Using word length (32 bits) for the map grid of the game (1bit/cell), the design is structured around 30 conway engines.
A Conway engine (conway_adder.vhd) is a simple processor for calculating the next state of a cell. It takes as input a 3x3 neighborhood of the previous state
and outputs a bit (1: alive, 0: dead) as the next state of the middle cell of the neighbourhood.
The design loads 1 32bit word each cycle and stores it on one of the 3 input buffers. At any given moment there is a 3x32 cell area loaded in lines in the 3 input buffers.
On each cycle the area is fed to the conway engines to produce the next state of the middle 30 cells of the area. 
On each next cycle the top line of the area is flooded from a buffer and replaced with the next one implementing a downard moving window of a 32 cell width.
This cycling of inputs is controlled by a module hadling the enable signals of the buffers: only 1 buffer is enabled at each cc. 
These enable signals also handle which of the buffers holds the middle cell.

The conway_top.sv is a systems verilog top module containing the conway design, the enable handler and ready/valid signals for the IO.
the conway_hwpe_tb.vhd is the testbench for the top module.
