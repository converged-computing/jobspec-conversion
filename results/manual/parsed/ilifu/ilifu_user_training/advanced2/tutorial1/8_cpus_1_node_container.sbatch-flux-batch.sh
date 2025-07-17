#!/bin/bash
#FLUX: --job-name=8-cpus-1-node-container
#FLUX: -t=60
#FLUX: --urgency=16

echo "Submitting SLURM job: simple_mpi.py using Singularity container over 8 cores & 1 node"
module add mpich/3.3a2
mpirun singularity exec /idia/software/containers/ASTRO-PY3.simg python simple_mpi.py
