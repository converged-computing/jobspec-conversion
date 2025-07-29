#!/bin/bash
#SBATCH --job-name=week02
#SBATCH --output=output.log
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=12

module load openmpi/3.1.6-gcc-12.2.0-d2gmn55
mpiexec -np $SLURM_NTASKS ./heat_stencil_1D_mpi 4096
