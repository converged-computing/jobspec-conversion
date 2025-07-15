#!/bin/bash
#FLUX: --job-name=nerdy-hippo-3915
#FLUX: -n=64
#FLUX: --queue=amd
#FLUX: -t=13800
#FLUX: --priority=16

module purge
module load conda
source activate an
module load paraview/5.11
mpiexec -n $SLURM_NPROCS pvserver --connect-id=11111 --displays=0
