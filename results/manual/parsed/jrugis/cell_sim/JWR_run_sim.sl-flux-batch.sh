#!/bin/bash
#FLUX: --job-name=joyous-fork-6702
#FLUX: -t=3540
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/projects/nesi00119/code/JWR_petsc/petsc-3.5.4/linux-intel/lib:$LD_LIBRARY_PATH'

echo $HOSTNAME
module load intel/2015a
module load Python/2.7.9-intel-2015a
export LD_LIBRARY_PATH=/projects/nesi00119/code/JWR_petsc/petsc-3.5.4/linux-intel/lib:$LD_LIBRARY_PATH
srun -o sim.log ./src/cell_3d
