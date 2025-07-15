#!/bin/bash
#FLUX: --job-name=tart-chair-3267
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
