#!/bin/bash
#FLUX: --job-name=stinky-fork-9454
#FLUX: --urgency=16

module load python/3.10.12-fasrc01
source activate python3_env1
srun -n 8 --mpi=pmi2 python optimize_mpi.py
