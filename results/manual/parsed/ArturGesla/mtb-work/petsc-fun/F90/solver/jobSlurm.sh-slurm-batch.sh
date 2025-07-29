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
source ../../petsc.sh
set -x
time srun ./solver.exe
