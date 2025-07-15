#!/bin/bash
#FLUX: --job-name=arid-blackbean-6473
#FLUX: -t=900
#FLUX: --priority=16

module load opencl-intel/16.4 
module load opencl-nvidia/9.0
module load openmpi/gcc/64/1.10.3
./vexcl.out "$@"
