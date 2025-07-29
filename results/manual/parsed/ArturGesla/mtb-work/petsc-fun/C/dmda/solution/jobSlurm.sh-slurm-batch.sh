#!/bin/bash
#SBATCH --job-name=petscDMDA
#SBATCH --output=petscDMDA%j.out
#SBATCH --error=petscDMDA%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../../petsc.sh
set -x
time srun ./dmda.exe -da_grid_x 1000 -da_grid_y 1000 -ksp_type cg -pc_type hypre
