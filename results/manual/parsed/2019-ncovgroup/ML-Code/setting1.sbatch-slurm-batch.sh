#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:30:00
#SBATCH --constraint=ntasks-per-node=8

DASK=$HOME/scheduler.json
rm -f $DASK
mpirun -np 32 dask-mpi --scheduler-file $DASK --interface 'ib0' --nthreads=10 --memory-limit='15G' --no-nanny --local-directory=/tmp
