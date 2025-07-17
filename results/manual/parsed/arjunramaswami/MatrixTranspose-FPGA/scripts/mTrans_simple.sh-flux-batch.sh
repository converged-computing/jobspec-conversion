#!/bin/bash
#FLUX: --job-name=cmake_mTrans_opt
#FLUX: --queue=all
#FLUX: -t=86400
#FLUX: --urgency=16

module load intelFPGA_pro/20.4.0 nalla_pcie/19.4.0_hpc
cd ../build
make simple_syn
