#!/bin/bash
#FLUX: --job-name=mpi4py_test
#FLUX: -n=16
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --urgency=16

module load python/3.10.12-fasrc01
module load gcc/12.2.0-fasrc01
module load openmpi/4.1.5-fasrc03
source activate python3_env2
srun -n 16 --mpi=pmix python mpi4py_test.py
