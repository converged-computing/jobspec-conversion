#!/bin/bash
#FLUX: --job-name=conspicuous-motorcycle-4647
#FLUX: -c=32
#FLUX: --queue=csmpi_fpga_long
#FLUX: -t=14400
#FLUX: --urgency=16

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
