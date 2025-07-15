#!/bin/bash
#FLUX: --job-name=Design1
#FLUX: -N=4
#FLUX: -t=3600
#FLUX: --priority=16

nDV=11  # Number of design variables (x2 for central difference)
source deactivate
module purge
module load conda
module load mkl/2019.1.144 cmake/3.12.3
module load gcc/8.2.0
conda activate wisdem-env
mpirun -np $nDV python runWISDEM.py
