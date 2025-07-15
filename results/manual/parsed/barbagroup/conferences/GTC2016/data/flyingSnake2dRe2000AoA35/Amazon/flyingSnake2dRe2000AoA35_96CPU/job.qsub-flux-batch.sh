#!/bin/bash
#FLUX: --job-name="PetAmgX-flyingSnake2dRe2000AoA35-atol1e-5-Amazon-96CPU"
#FLUX: -N=8
#FLUX: --queue=compute
#FLUX: --priority=16

export PETIBM_DIR='/shared/petibm-amgx'

source /shared/envs.sh
export PETIBM_DIR=/shared/petibm-amgx
echo "2D flyingSnake Re2000 Amazon c4.8xlarge 96CPU aTol=1e-5 Short Period"
mpiexec -display-map -np 96 ${PETIBM_DIR}/bin/petibm2d -directory /shared/Cases/flyingSnake2dRe2000AoA35_Amazon_96CPU
