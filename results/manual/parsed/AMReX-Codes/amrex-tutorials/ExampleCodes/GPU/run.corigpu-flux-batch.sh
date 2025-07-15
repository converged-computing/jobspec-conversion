#!/bin/bash
#FLUX: --job-name=purple-cupcake-3971
#FLUX: --priority=16

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
