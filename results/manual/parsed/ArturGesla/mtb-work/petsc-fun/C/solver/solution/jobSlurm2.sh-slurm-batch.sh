#!/bin/bash
#SBATCH --job-name=petscKSP
#SBATCH --output=petscKSP%j.out
#SBATCH --error=petscKSP%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../../petsc.sh
set -x
time mpirun -np 4  ./solver.exe -ksp_type preonly -pc_type lu -pc_factor_mat_solver_type mumps -size 1000
