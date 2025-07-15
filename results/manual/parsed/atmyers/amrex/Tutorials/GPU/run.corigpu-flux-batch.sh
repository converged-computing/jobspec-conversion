#!/bin/bash
#FLUX: --job-name=astute-punk-2234
#FLUX: --urgency=16

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
