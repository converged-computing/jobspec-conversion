#!/bin/bash
#FLUX: --job-name=petscVec
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module purge
source ../../petsc.sh
set -x
echo "-------------- Run of Vec2a ----------------"
time srun ./vec2a.exe
echo "-------------- Run of Vec2b ----------------"
time srun ./vec2b.exe
echo "-------------- Run of Vec2c ----------------"
time srun ./vec2c.exe
