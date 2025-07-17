#!/bin/bash
#FLUX: --job-name=AMReX
#FLUX: -N=4
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: -t=600
#FLUX: --urgency=16

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
