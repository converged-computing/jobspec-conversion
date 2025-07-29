#!/bin/bash
#FLUX: --job-name=PetAmgX-flyingSnake2dRe2000AoA35-atol1e-5-96CPU
#FLUX: -N=8
#FLUX: --queue=allgpu-noecc
#FLUX: -t=172800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:/c1/apps/cuda/driver/352.63/lib'
export PETIBM_DIR='/home/pychuang/petibm-amgx'

source /home/pychuang/moduleLoad.sh
source /home/pychuang/petibm-amgx/envs.sh
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/c1/apps/cuda/driver/352.63/lib
export PETIBM_DIR=/home/pychuang/petibm-amgx
echo "2D flyingSnake Re2000 96CPU aTol=1e-5 Short Period"
mpiexec -display-map -np 96 ${PETIBM_DIR}/bin/petibm2d -directory /home/pychuang/Cases/flyingSnake/atol_1e-5_short/flyingSnake2dRe2000AoA35_96CPU
