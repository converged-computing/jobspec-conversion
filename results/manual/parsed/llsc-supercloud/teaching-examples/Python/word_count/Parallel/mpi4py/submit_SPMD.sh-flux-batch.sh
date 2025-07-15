#!/bin/bash
#FLUX: --job-name=milky-noodle-0596
#FLUX: --priority=16

module load anaconda/2023a
module load mpi/openmpi-4.1.3
mpirun python top5norm_SPMD.py
