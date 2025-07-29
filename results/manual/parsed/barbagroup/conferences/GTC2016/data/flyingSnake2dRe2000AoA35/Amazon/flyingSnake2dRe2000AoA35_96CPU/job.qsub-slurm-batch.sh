#!/bin/bash
#SBATCH --job-name=PetAmgX-flyingSnake2dRe2000AoA35-atol1e-5-Amazon-96CPU
#SBATCH --output=job-%j.out
#SBATCH --error=job-%j.err
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=12

export PETIBM_DIR='/shared/petibm-amgx'

source /shared/envs.sh
export PETIBM_DIR=/shared/petibm-amgx
echo "2D flyingSnake Re2000 Amazon c4.8xlarge 96CPU aTol=1e-5 Short Period"
mpiexec -display-map -np 96 ${PETIBM_DIR}/bin/petibm2d -directory /shared/Cases/flyingSnake2dRe2000AoA35_Amazon_96CPU
