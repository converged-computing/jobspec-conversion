#!/bin/bash
#SBATCH --job-name=main
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=shared-gpu

cores=20
srun -N 1 -n 1 -c $cores -o test.out --open-mode=append ./main_wrapper.sh  
