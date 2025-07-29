#!/bin/bash
#SBATCH --job-name=MyMPIJob
#SBATCH --output=MyMPIJob-%j.out
#SBATCH --error=MyMPIJob-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

srun --mpi=pmix ./MyMPIProgram
