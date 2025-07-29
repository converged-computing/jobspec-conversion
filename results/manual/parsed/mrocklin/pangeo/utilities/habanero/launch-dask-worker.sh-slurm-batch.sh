#!/bin/bash
#SBATCH --job-name=dask-worker
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --exclusive

module load anaconda
source activate pangeo
SCHEDULER=$HOME/scheduler.json
mpirun --np 6 dask-mpi --nthreads 4 \
    --memory-limit 12e9 \
    --interface ib0 \
    --no-scheduler --local-directory /local \
    --scheduler-file=$SCHEDULER
