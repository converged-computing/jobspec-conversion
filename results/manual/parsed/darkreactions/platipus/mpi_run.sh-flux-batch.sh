#!/bin/bash
#FLUX: --job-name=arid-leopard-4022
#FLUX: --urgency=16

module load python3
module list
pwd
date
ibrun python3 run_mpi.py         # Use ibrun instead of mpirun or mpiexec
