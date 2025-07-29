#!/bin/bash
#SBATCH --job-name=threads
#SBATCH --account=project_2001659
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --time=00:15:00
#SBATCH --partition=test
#SBATCH --constraint=ntasks-per-node=1

export JULIA_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load julia/1.8.5
export JULIA_NUM_THREADS="$SLURM_CPUS_PER_TASK"
srun julia --project=. benchmark.jl -n 1000000000
