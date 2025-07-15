#!/bin/bash
#FLUX: --job-name=placid-staircase-9364
#FLUX: --priority=16

export PATH='/public21/soft/cp2k/8.1/exe/local:$PATH'
export CP2K_DATA_DIR='/public21/soft/cp2k/8.1/data'

source /public21/soft/modules/module.sh
module load gcc/7.3.0-kd
module load  mpi/openmpi/4.1.1-gcc7.3.0
export PATH=/public21/soft/cp2k/8.1/exe/local:$PATH
source /public21/soft/cp2k/8.1/tools/toolchain/install/setup
export CP2K_DATA_DIR=/public21/soft/cp2k/8.1/data
mpirun cp2k.psmp -i OT.inp -o tem.out
