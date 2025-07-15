#!/bin/bash
#FLUX: --job-name=expensive-fork-0446
#FLUX: --urgency=16

module load python/3.10.12-fasrc01
module load gcc/12.2.0-fasrc01
module load openmpi/4.1.5-fasrc03
source activate python3_env2
srun -n 8 --mpi=pmix python optimize_mpi.py
