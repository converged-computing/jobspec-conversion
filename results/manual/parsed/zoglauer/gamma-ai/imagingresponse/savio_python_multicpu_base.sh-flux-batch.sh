#!/bin/bash
#FLUX: --job-name=angry-hobbit-9340
#FLUX: -c=24
#FLUX: --queue=savio2
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "Starting submit on host ${HOST}..."
echo "Loading modules..."
module load gcc/6.3.0 cmake python/3.6 blas cuda tensorflow/1.10.0-py36-pip-cpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Starting script"
python3 -u ToyModel2DGauss.py
echo "Done with script"
wait
