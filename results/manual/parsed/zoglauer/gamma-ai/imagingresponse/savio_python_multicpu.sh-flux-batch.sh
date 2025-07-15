#!/bin/bash
#FLUX: --job-name=evasive-latke-5396
#FLUX: -c=24
#FLUX: --queue=savio2
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "Starting submit on host ${HOST}..."
echo "Loading modules..."
module load gcc/6.3.0 cmake python/3.6 cuda tensorflow
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
python3 -u ToyModel2DGaussSmooth.py
wait
