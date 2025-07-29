#!/bin/bash
#SBATCH --account=xxx
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=gpu

module load PrgEnv-nvidia
make clean ; make
srun -n 2 ./bcast_from_device
