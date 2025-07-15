#!/bin/bash
#FLUX: --job-name=petscKSP
#FLUX: -n=2
#FLUX: -t=600
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../../petsc.sh
set -x
time srun ./solver.exe -size 1000
echo "---------------------------------------------------------------------------------------"
time srun ./solver.exe -ksp_type cg -size 1000
echo "---------------------------------------------------------------------------------------"
time srun ./solver.exe -ksp_type minres -size 1000
echo "---------------------------------------------------------------------------------------"
time srun ./solver.exe -ksp_type bcgs -size 1000
echo "---------------------------------------------------------------------------------------"
time srun ./solver.exe -ksp_type cg -pc_type jacobi -size 1000
echo "---------------------------------------------------------------------------------------"
time srun ./solver.exe -ksp_type cg -pc_type asm -size 1000 -ksp_max_it 2000 # No convergence because non-symmetric preconditioner.
time srun ./solver.exe -ksp_type gmres -pc_type asm -size 1000
echo "---------------------------------------------------------------------------------------"
time srun ./solver.exe -ksp_type cg -pc_type hypre -size 1000
echo "---------------------------------------------------------------------------------------"
time srun ./solver.exe -ksp_type preonly -pc_type lu -pc_factor_mat_solver_type mumps -size 1000
echo "---------------------------------------------------------------------------------------"
time srun ./solver.exe -ksp_type cg -pc_type jacobi -ksp_norm_type unpreconditioned -size 1000
echo "---------------------------------------------------------------------------------------"
time srun ./solver.exe -ksp_type cg -pc_type hypre -ksp_norm_type unpreconditioned -size 1000
