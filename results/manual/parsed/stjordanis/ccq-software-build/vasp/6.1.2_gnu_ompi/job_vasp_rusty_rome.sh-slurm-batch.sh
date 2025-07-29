#!/bin/bash
#SBATCH --job-name=vasp
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=128,rome

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module purge
module load slurm vasp/6.1.2_gnu_ompi/module-rome
mpirun vasp_std
