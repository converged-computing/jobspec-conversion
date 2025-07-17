#!/bin/bash
#FLUX: --job-name=expressive-toaster-0336
#FLUX: --queue=ShmemQ
#FLUX: -t=259200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load intel/2020u4
module load conda
echo "Starting Dask Cluster"
echo "With" $1 "-1 workers"
echo "Scheduler is" $2".json"
mpirun --np $1 dask-mpi --scheduler-file $2".json" #--interface ib0
echo "Dask Cluster stopped"
