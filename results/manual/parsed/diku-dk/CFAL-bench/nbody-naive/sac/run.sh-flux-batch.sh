#!/bin/bash
#FLUX: --job-name=swampy-noodle-9674
#FLUX: -c=32
#FLUX: --queue=csmpi_fpga_long
#FLUX: -t=14400
#FLUX: --priority=16

export XILINX_XRT='/opt/xilinx/xrt'

export XILINX_XRT=/opt/xilinx/xrt
make clean
make -j3
echo "Sequential"
bin/nbody_seq
echo "MT"
bin/nbody_mt -mt 32
echo "Cuda"
bin/nbody_cuda
