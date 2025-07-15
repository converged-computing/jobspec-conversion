#!/bin/bash
#FLUX: --job-name=stinky-pastry-9138
#FLUX: -n=4
#FLUX: --priority=16

module load mpi4py
module load python/3.6
srun --mpi=pmix ./p2p.py
