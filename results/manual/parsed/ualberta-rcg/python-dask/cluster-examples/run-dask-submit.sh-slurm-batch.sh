#!/bin/bash
#SBATCH --account=cc-debug
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1024M
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=8

export NUM_WORKERS='8'
export THREADS_PER_WORKER='1'
export MEM_PER_WORKER='256mb'
export SCHEDULER_FILE='${SLURM_JOB_ID}-scheduler.json'

export NUM_WORKERS=8
export THREADS_PER_WORKER=1
export MEM_PER_WORKER=256mb
export SCHEDULER_FILE=${SLURM_JOB_ID}-scheduler.json
source ~/virtualenv/dask/bin/activate
dask-scheduler --host 127.0.0.1 \
               --no-dashboard \
               --scheduler-file $SCHEDULER_FILE &
sleep 15
for worker in `seq $NUM_WORKERS`
do
dask-worker --scheduler-file $SCHEDULER_FILE \
            --no-dashboard \
            --no-nanny \
            --nprocs 1 \
            --nthreads $THREADS_PER_WORKER \
            --memory-limit $MEM_PER_WORKER &
done
sleep 15
time python run-dask.py
