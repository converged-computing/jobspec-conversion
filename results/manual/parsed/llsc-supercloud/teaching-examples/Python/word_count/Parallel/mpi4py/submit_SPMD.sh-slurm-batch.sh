#!/bin/bash
#SBATCH --output=top5norm_SPMD.log-%j
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1

module load anaconda/2023a
module load mpi/openmpi-4.1.3
mpirun python top5norm_SPMD.py
