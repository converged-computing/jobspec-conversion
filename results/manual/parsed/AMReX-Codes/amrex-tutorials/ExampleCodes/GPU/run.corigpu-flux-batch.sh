#!/bin/bash
#FLUX: --job-name=scruptious-nunchucks-3363
#FLUX: --urgency=16

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
