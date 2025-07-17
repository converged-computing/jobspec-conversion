#!/bin/bash
#FLUX: --job-name=expressive-hobbit-6587
#FLUX: -N=32
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=thin
#FLUX: -t=1800
#FLUX: --urgency=16

module load 2021
module load foss/2021a
srun julia --project -O3 -t4 drycbl_init.jl --use-mpi --npx 32 --npy 32
srun julia --project -O3 -t4 drycbl_run.jl --use-mpi --npx 32 --npy 32
