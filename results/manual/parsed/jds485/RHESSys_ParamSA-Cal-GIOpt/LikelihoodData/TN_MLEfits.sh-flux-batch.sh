#!/bin/bash
#FLUX: --job-name=evasive-train-1776
#FLUX: --priority=16

module purge
module load gcc/7.1.0 openmpi/3.1.4 python/3.6.6 mpi4py
mpirun python TN_MLEfits.py
