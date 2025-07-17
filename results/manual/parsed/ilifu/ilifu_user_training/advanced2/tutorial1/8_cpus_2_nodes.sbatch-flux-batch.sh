#!/bin/bash
#FLUX: --job-name=8-cpus-2-nodes
#FLUX: -N=2
#FLUX: -t=60
#FLUX: --urgency=16

echo "Submitting SLURM job: simple_mpi.py using 8 cores & 2 nodes"
module add openmpi/4.0.3
mpirun python simple_mpi.py
