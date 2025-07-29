#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=01:00:00
#SBATCH --partition=thin
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=32

module load 2021
module load foss/2021a
srun julia --project -O3 -t4 drycbl_init.jl --use-mpi --npx 8 --npy 16
srun julia --project -O3 -t4 drycbl_run.jl --use-mpi --npx 8 --npy 16
