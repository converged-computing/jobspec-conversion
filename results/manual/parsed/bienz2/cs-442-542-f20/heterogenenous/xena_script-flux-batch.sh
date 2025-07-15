#!/bin/bash
#FLUX: --job-name=hw6
#FLUX: -N=2
#FLUX: --queue=dualGPU
#FLUX: -t=3600
#FLUX: --priority=16

source ~/.bashrc
module load cuda
module load openmpi
module load gcc/8.3.0-wbma
nvidia-smi
cd /users/bienz/cs-442-542-f20/heterogenenous
mpirun -n 16 ./hello_world
