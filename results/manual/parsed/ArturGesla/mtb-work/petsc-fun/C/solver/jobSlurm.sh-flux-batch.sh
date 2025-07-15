#!/bin/bash
#FLUX: --job-name=petscKSP
#FLUX: -n=8
#FLUX: -t=600
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../petsc.sh
n=1000;
time srun ./solver.exe -size $n -ksp_type preonly -pc_type lu -pc_factor_mat_solver_type mumps -log_view
echo "dir timing";
