#!/bin/bash
#FLUX: --job-name=submission
#FLUX: -n=16
#FLUX: -t=600
#FLUX: --urgency=16

module use /usr/local.nfs/sgs/modulefiles
module load vtk/8.2
module load gcc/8.2
module load cmake/cmake-3.12.3
srun -n 2 ../build/src/numsim_parallel lid_driven_cavity.txt
