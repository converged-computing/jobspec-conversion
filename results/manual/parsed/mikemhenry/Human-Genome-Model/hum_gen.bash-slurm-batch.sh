#!/bin/bash
#SBATCH --output=logs/gpu-job-%j.o
#SBATCH --error=logs/gpu-job-%j.e
#SBATCH --mail-user=mattferguson@boisestate.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpuq

ulimit -u 9999
ulimit -s unlimited
ulimit -v unlimited
module load hoomd-blue/gcc/mvapich2/2.1.5
mpirun python hum_gen.py
