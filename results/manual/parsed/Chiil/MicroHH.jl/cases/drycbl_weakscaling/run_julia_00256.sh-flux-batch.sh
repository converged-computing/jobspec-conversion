#!/bin/bash
#FLUX: --job-name=purple-noodle-1501
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=thin
#FLUX: -t=3600
#FLUX: --priority=16

module load 2021
module load foss/2021a
srun julia --project -O3 -t4 drycbl_init.jl --use-mpi --npx 8 --npy 8
srun julia --project -O3 -t4 drycbl_run.jl --use-mpi --npx 8 --npy 8
