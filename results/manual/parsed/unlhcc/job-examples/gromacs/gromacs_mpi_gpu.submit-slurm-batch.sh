#!/bin/bash
#FLUX: --job-name=gromacs_mpi_gpu
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load compiler/gcc/10 openmpi/4.1 gromacs-gpu/2023
mpirun gmx mdrun -nb gpu -pme gpu -bonded gpu -npme 1
