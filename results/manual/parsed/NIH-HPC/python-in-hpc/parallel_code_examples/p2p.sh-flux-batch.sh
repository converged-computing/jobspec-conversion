#!/bin/bash
#FLUX: --job-name=dinosaur-pastry-4195
#FLUX: -n=4
#FLUX: --urgency=16

module load mpi4py
module load python/3.6
srun --mpi=pmix ./p2p.py
