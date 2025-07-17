#!/bin/bash
#FLUX: --job-name=Bench-CU
#FLUX: --exclusive
#FLUX: --queue=c18g
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='24'
export OMP_THREAD_LIMIT='24'

module load DEVELOP
module load gcc/9
module load cuda/11.2
source ~/.zshrc.local
cd ${CALS_DIR} || exit
cd build_cuda || exit
make -j 48
numactl -H
numactl --cpubind=0,1 --membind=0,1 -- numactl -show
export OMP_NUM_THREADS=24
export OMP_THREAD_LIMIT=24
numactl --cpubind=0,1 --membind=0,1 -- ./src/experiments/experiments_jk 24
