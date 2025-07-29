#!/bin/bash
#SBATCH --job-name=SWM
#SBATCH --account=NTDD0002
#SBATCH --output=SWM.out
#SBATCH --error=SWM.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=dav
#SBATCH --constraint=ntasks-per-node=18

module purge
module list
gcc -g -lm shallow_swap.c wtime.c -o SWM_val
valgrind --leak-check=yes ./SWM_val
