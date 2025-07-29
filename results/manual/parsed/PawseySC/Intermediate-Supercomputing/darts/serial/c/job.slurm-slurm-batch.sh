#!/bin/bash
#SBATCH --job-name=darts-serial
#SBATCH --account=courses01
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

module swap PrgEnv-cray PrgEnv-intel 
srun --export=all -n 1 ./darts
