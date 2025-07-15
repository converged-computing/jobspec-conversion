#!/bin/bash
#FLUX: --job-name=anxious-signal-3329
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
