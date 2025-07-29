#!/bin/bash
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:30:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=32

module load 2021
module load foss/2021a
srun julia --project -O3 -t4 drycbl_init.jl --use-mpi --npx 32 --npy 32
srun julia --project -O3 -t4 drycbl_run.jl --use-mpi --npx 32 --npy 32
