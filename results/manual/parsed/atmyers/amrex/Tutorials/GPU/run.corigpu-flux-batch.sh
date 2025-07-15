#!/bin/bash
#FLUX: --job-name=stanky-citrus-1949
#FLUX: --priority=16

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
