#!/bin/bash
#SBATCH --job-name=ior
#SBATCH --output=%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1

mpirun  hostname
nvidia-smi
