#!/bin/bash
#SBATCH --output=job1.out
#SBATCH --error=job1.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:10
#SBATCH --constraint=ntasks-per-node=16

module unload openmpi 
module load mpi4py/1.3+python-2.7-2015q2
mpirun python bcast.py
