#!/bin/bash
#FLUX: --job-name=bumfuzzled-gato-1090
#FLUX: -t=86400
#FLUX: --priority=16

module load intelFPGA_pro/20.4.0 nalla_pcie/19.4.0_hpc
cd ../build
make simple_syn
