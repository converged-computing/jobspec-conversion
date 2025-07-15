#!/bin/bash
#FLUX: --job-name=veros_mysetup
#FLUX: -N=2
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
veros resubmit -i my_run -n 8 -l 7776000 \
    -c "srun --mpi=pmi2 -- veros run my_setup.py -b jax -n 4 4" \
    --callback "sbatch veros_batch.sh"
