#!/bin/bash
#FLUX: --job-name=ornery-cherry-3894
#FLUX: --priority=16

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
