#!/bin/bash
#FLUX: --job-name=gromacs_mpi
#FLUX: -n=4
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load compiler/gcc/10 openmpi/4.1 gromacs-gpu/2023
mpirun gmx mdrun
