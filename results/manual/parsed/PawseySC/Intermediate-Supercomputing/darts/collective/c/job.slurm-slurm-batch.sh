#!/bin/bash
#SBATCH --job-name=darts-collective
#SBATCH --account=courses01
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

module swap PrgEnv-cray PrgEnv-intel 
srun --export=all -n 24 darts-collective
