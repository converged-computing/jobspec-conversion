#!/bin/bash
#SBATCH --job-name=test-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=6

module load singularity
module unload mvapich2_ib
module load openmpi_ib
rm -f test-results-gpu.out
ibrun -n 1 singularity exec --nv software.simg python3 serial-gpu.py
