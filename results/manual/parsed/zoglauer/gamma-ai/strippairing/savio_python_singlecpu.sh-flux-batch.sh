#!/bin/bash
#FLUX: --job-name=anxious-house-2744
#FLUX: --queue=savio2_htc
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "Starting submit on host ${HOST}..."
echo "Loading modules..."
module load gcc/4.8.5 cmake python/3.6 cuda tensorflow
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
python3 explorelayouts.py -b -f StripPairing.x2.y2.strippairing.root -l 1 -n 20 -m 1000  -o 2TwoLayerTestRun
wait
