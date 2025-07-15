#!/bin/bash
#FLUX: --job-name=psycho-earthworm-6876
#FLUX: --priority=16

module load python3
module list
pwd
date
ibrun python3 run_mpi.py         # Use ibrun instead of mpirun or mpiexec
