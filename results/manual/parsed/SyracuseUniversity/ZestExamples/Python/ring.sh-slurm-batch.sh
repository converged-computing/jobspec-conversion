#!/bin/bash
#SBATCH --output=output/ring.out
#SBATCH --error=output/ring.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=1

eval "$(/home/$(whoami)/miniconda3/bin/conda shell.bash hook)"
mpirun ./ring.py
