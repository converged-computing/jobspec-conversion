#!/bin/bash
#FLUX: --job-name=lovable-citrus-6419
#FLUX: --queue=csmpi_fpga_short
#FLUX: -t=300
#FLUX: --urgency=16

export XILINX_XRT='/opt/xilinx/xrt'

export XILINX_XRT=/opt/xilinx/xrt
BUILD=RELEASE make bin/square_cl
bin/square_cl > results/square.txt
