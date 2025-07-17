#!/bin/bash
#FLUX: --job-name=singularity-mpi
#FLUX: -c=2
#FLUX: -t=300
#FLUX: --urgency=16

export NNODES='2'

export NNODES=2
module load intel intelmpi
mpirun -n 2 singularity exec matrixMul.sif /opt/main
