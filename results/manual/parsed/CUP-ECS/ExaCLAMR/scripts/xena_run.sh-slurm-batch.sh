#!/bin/bash
#SBATCH --job-name=ExaCLAMR
#SBATCH --output=multiprocess_%j.log
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --time=01:00:00

module purge
module load gcc/8.3.0-wbma
module load openmpi/4.0.5-cuda-rla7
module load cmake
module load cuda/11.2.0-qj6z
mkdir -p data
mkdir -p data/raw
rm -rf data/raw/*
srun -N 2 -n 2 ./build/examples/DamBreak -mcuda -n1000 -t100 -w10
