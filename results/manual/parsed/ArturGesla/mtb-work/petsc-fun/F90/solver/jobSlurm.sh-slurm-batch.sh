#!/bin/bash
#FLUX: --job-name=petscKSP
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../petsc.sh
set -x
time srun ./solver.exe
