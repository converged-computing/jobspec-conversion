#!/bin/bash
#SBATCH --job-name=mnist_pippy
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=8

srun --label pippy_wrapper.sh
