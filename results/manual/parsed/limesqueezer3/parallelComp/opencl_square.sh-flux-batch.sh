#!/bin/bash
#FLUX --job-name=milky-banana-3126
#FLUX --queue=csmpi_fpga_short
#FLUX -t=300
#FLUX --urgency=16

export XILINX_XRT='/opt/xilinx/xrt'

export XILINX_XRT=/opt/xilinx/xrt
BUILD=RELEASE make bin/square_cl
bin/square_cl > results/square.txt
