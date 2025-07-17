#!/bin/bash
#FLUX: --job-name=salted-dog-9920
#FLUX: -N=2
#FLUX: --queue=DevQ
#FLUX: -t=3600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load intel/2020u4
module load conda
echo "Starting Dask Cluster"
mpirun --np 21 dask-mpi --scheduler-file scheduler.json --interface ib0
echo "Dask Cluster stopped"
