# gen_amba_axi
Prerequisites
This program requires followings.

Shell: Bash
GNU GCC: C compiler
HDL simulator: Xilinx Vivado simulator, icarus Verilog, or Mentor Graphics ModelSim
Maturity
RTL simulation
FPGA proven (refer to CON-FMC)
ASIC partially proven, but not whole yet
Limitations
For AMBA AXI, master should be 2 or larger and slave should be 2 or larger.
1. Quick start for AMBA AXI and AHB
1.1 Quick start for AMBA AXI
1.1.1 generating AMBA AXI
Click to expand
go to 'gen_amba_axi' directory
$ cd gen_amba_axi
run Makefile
$ make cleanup
$ make
. It should generate 'gen_amba_axi'.
have a look the help message
$ ./gen_amba_axi -h
generate AMBA AXI
$ ./gen_amba_axi --master=2 --slave=3 --output=amba_axi_m2s3.v
. It generates an AXI bus ("amba_axi_m2s3.v") with 2 master-ports and 3 slave-ports.
1.1.2 verification AMBA AXI
go to 'gen_amba_axi/verification/sim/xsim' directory
$ cd gen_amba_axi/verification/sim/xsim
. Use 'iverilog' for Icarus Verilog.
run Makefile
$ make cleanup
$ make MST=2 SLV=3
. It should generate necessary bus and top model and then invoke HDL simulator.
. It uses top-level generator.
have a look the result VCD wave
$ gtkwave wave.vcd
1.1.3 change verification configuration
how to change the number of masters and slaves

modify 'MST' and 'SLV' macro in the 'Makefile' in 'gen_amba_axi/verification/sim/xsim' directory or
set command-line option of 'make' as follows
$ make MST=3 SLV=3
how to change width of address and data

modify 'WIDTH_AD' and 'WIDTH_DA' macros in 'sim_define.v' in 'gen_amba_axi/verification/sim/xsim' directory
how to change testing scenario

set 1 for the verilog plus command-line argument in the 'Makefile' in 'gen_amba_axi/verification/sim/xsim' directory
[xsim case] -testplusarg BURST_TEST=1
[iverilog case] +BURST_TEST=1
[ModelSim case] +BURST_TEST=1
how to add new testing scenario

add your scenario in the 'axi_tester.v' file in the 'gen_amba_axi/verification/ip' directory, where you can find some testing scenarios.
there is AMBA AXI task library in the 'gen_amba_axi/verification/ip/axi_master_tasks.v'.
2.1 gen_amba_axi
It generates AMBA AXI switch.

Click to expand
$ ./gen_amba_axi -h
[Usage] ./gen_amba_axi [options]
	-M,--master=num   num of masters (default: 2)
	-S,--slave=num    num of slaves  (default: 2)
	-D,--module=str   module name (default: "amba_axi_mXsY")
	-P,--prefix=str   prefix of module (default: none)
	-O,--output=file  output file name (stdout if not given)
	-3,--axi3         force to use AXI3 (AIX4 by default, if not given)
	-g,--verbose=num  verbose level  (default: 0)
	-v,--version      print version
	-l,--license      print license message
	-h                print help message
'--prefix' option makes use of prefix for the internal modules and this enables to use multiple AXI buses in the same design by preventing from warning of multiple definition modules.

'--axi3' option forces to generate AMBA AXI3, which uses 'AxLENG[3:0]', 'AxLOCK[1:0]', and 'WID[..]', while without '--axi3' option 'gen_amba_axi' generates AMBA AXI4.


AMBA AXI switch
AMBA AXI internal structure
https://github.com/adki/gen_amba_2021/blob/main/doc/images/axi_bus.png
