#!/bin/bash
#FLUX: --job-name=butterscotch-lettuce-6172
#FLUX: -c=24
#FLUX: --queue=savio2
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "Starting submit on host ${HOSTNAME}..."
echo "Loading modules..."
module load gcc/4.8.5 cmake python/3.6 cuda tensorflow
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
python3 -u run.py -f 1MeV_50MeV_flat.p1.inc18166611.id1.sim.gz
wait
