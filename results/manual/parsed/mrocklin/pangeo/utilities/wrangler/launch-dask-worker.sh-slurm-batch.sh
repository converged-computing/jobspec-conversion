#!/bin/bash
#SBATCH --job-name=dask-worker
#SBATCH --output=worker.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

module purge
source activate pangeo
LDIR=/gpfs/flash/users/$USER
SCHEDULER=$HOME/scheduler.json
dask-worker --memory-limit 0.15 --nthreads 4 --nprocs 6 \
            --local-directory $LDIR \
            --scheduler-file=$SCHEDULER \
            --interface ib0 
