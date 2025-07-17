#!/bin/bash
#FLUX: --job-name=delicious-caramel-5898
#FLUX: -n=4
#FLUX: --urgency=16

module load anaconda/2023a
module load mpi/openmpi-4.1.3
mpirun python top5norm_SPMD.py
