#!/bin/bash
#FLUX: --job-name=AMREX_GPU
#FLUX: -n=8
#FLUX: -c=10
#FLUX: -t=300
#FLUX: --urgency=16

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
