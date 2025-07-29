#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=i8cpu

srun -n 8 abics_sampling input.toml >> abics_sampling.out
echo Done
