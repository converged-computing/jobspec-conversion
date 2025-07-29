#!/bin/bash
#SBATCH --job-name=hpc
#SBATCH --output=output.out
#SBATCH --nodes=90
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6gb
#SBATCH --time=00:30:00
#SBATCH --partition=multiple
#SBATCH --constraint=ntasks-per-node=40

module load devel/python/3.8.6_gnu_10.2
module load mpi/openmpi/4.1
SECONDS=0
mpirun -n 3600 python milestone7.py 200000 10000 1000 1000 1.6 0.2 60 60
echo $SECONDS
