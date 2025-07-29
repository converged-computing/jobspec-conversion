#!/bin/bash
#SBATCH --account=courses0100
#SBATCH --nodes=2
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

module load python/3.10.10
module load py-mpi4py/3.1.4-py3.10.10
set -ex
srun -n 12 python hello.py
