#!/bin/bash
#SBATCH --job-name=petscVec
#SBATCH --output=petscVec%j.out
#SBATCH --error=petscVec%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../../petsc.sh
set -x
echo "-------------- Run of Vec2a ----------------"
time srun ./vec2a.exe
echo "-------------- Run of Vec2b ----------------"
time srun ./vec2b.exe
echo "-------------- Run of Vec2c ----------------"
time srun ./vec2c.exe
