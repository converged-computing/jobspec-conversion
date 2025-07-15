#!/bin/bash
#FLUX: --job-name=gromacs_gpu
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --priority=16

module purge
module load compiler/gcc/10 gromacs-gpu/2023
gmx mdrun -nt 1 -nb gpu -pme gpu -bonded gpu
