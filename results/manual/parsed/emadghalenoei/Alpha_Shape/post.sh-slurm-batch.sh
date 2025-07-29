#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60G
#SBATCH --time=5-00:00:00
#SBATCH --partition=geo
#SBATCH --constraint=ntasks-per-node=20

module load mpich/3.2.1-gnu
mpirun -np 20 python3 Posterior_Process.py
