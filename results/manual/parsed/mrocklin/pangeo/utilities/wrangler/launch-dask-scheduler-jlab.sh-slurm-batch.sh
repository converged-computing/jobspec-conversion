#!/bin/bash
#SBATCH --job-name=dask-scheduler
#SBATCH --output=scheduler.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=normal

export JUPYTER_RUNTIME_DIR='$WORK'

module purge
source activate pangeo
LDIR=/gpfs/flash/users/$USER
export JUPYTER_RUNTIME_DIR=$WORK
jupyter lab --ip '*' --no-browser --port 8888 \
            --notebook-dir $HOME &
SCHEDULER=$HOME/scheduler.json
rm -f $SCHEDULER
dask-scheduler --scheduler-file $SCHEDULER \
               --local-directory $LDIR &
while [ ! -f $SCHEDULER ]; do 
    sleep 1
done
dask-worker --memory-limit 0.15 --nthreads 4 --nprocs 5 \
            --local-directory $LDIR \
            --scheduler-file=$SCHEDULER \
            --interface ib0 
