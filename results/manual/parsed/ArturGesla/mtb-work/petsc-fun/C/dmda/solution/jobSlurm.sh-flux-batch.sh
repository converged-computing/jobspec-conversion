#!/bin/bash
#FLUX: --job-name=petscDMDA
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../../petsc.sh
set -x
time srun ./dmda.exe -da_grid_x 1000 -da_grid_y 1000 -ksp_type cg -pc_type hypre
