#!/bin/bash
#FLUX: --job-name=p2p_test
#FLUX: -n=4
#FLUX: --urgency=16

module load mpi4py
module load python/3.6
srun --mpi=pmix ./p2p.py
