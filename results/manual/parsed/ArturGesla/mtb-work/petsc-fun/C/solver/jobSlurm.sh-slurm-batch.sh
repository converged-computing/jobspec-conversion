#!/bin/bash
#SBATCH --job-name=petscKSP
#SBATCH --output=petscKSP%j.out
#SBATCH --error=petscKSP%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../petsc.sh
n=1000;
time srun ./solver.exe -size $n -ksp_type preonly -pc_type lu -pc_factor_mat_solver_type mumps -log_view
echo "dir timing";
