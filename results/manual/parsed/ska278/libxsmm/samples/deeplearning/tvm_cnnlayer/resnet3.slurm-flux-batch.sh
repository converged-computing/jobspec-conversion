#!/bin/bash
#FLUX: --job-name=resnet3
#FLUX: --queue=clx
#FLUX: -t=86400
#FLUX: --urgency=16

export KMP_AFFINITY='granularity=fine,compact,1,28'
export OMP_NUM_THREADS='28'
export TVM_NUM_THREADS='28'

export KMP_AFFINITY=granularity=fine,compact,1,28
export OMP_NUM_THREADS=28
export TVM_NUM_THREADS=28
LD_PRELOAD=./libxsmm_wrapper/libxsmm_wrapper.so srun python -u mb1_tuned_latest.py -d resnet3
