#!/bin/bash
#SBATCH --output=job1.out
#SBATCH --error=job1.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=8

module load Anaconda2
mpirun python bcast.py
