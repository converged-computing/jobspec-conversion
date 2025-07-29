#!/bin/bash
#SBATCH --output=pview.out
#SBATCH --error=pview.out
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=06:50:00
#SBATCH --partition=amd

module purge
module load paraview/5.10.1 python/3.11
mpiexec -n $SLURM_NPROCS pvserver --connect-id=11111 --displays=0
