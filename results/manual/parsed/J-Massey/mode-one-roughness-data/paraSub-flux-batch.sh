#!/bin/bash
#FLUX: --job-name=salted-earthworm-4394
#FLUX: -n=64
#FLUX: --queue=amd
#FLUX: -t=24600
#FLUX: --urgency=16

module purge
module load paraview/5.10.1 python/3.11
mpiexec -n $SLURM_NPROCS pvserver --connect-id=11111 --displays=0
