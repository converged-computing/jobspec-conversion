#!/bin/bash
#SBATCH --job-name=openmpi_threads
#SBATCH --account=project_2001659
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1000
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=2

export JULIA_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load julia/1.8.5
export JULIA_NUM_THREADS="$SLURM_CPUS_PER_TASK"
srun julia --project=. test.jl
