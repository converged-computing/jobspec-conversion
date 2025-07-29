#!/bin/bash
#FLUX: --job-name=petscKSP
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../../petsc.sh
set -x
time mpirun -np 4  ./solver.exe -ksp_type preonly -pc_type lu -pc_factor_mat_solver_type mumps -size 1000
