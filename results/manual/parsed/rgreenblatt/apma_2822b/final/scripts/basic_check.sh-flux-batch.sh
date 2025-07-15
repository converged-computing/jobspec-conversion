#!/bin/bash
#FLUX: --job-name=hello-lizard-9566
#FLUX: -n=2
#FLUX: -c=4
#FLUX: -t=600
#FLUX: --priority=16

module load cuda/10.0.130
module load mpi/mvapich2-2.3b_gcc
srun --mpi=pmi2 ./bin/miniFE -nx 300 -ny 300 -nz 300 &
nvidia-smi -l 1
