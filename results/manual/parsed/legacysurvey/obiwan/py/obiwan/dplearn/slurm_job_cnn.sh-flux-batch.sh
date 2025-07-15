#!/bin/bash
#FLUX: --job-name=hairy-cherry-7897
#FLUX: --priority=16

export OMP_NUM_THREADS='68'
export KMP_AFFINITY='granularity=fine,verbose,compact,1,0'
export KMP_SETTINGS='1'
export KMP_BLOCKTIME='1'
export isKNL='yes'

module load tensorflow/intel-head
export OMP_NUM_THREADS=68
export KMP_AFFINITY="granularity=fine,verbose,compact,1,0"
export KMP_SETTINGS=1
export KMP_BLOCKTIME=1
export isKNL=yes
date
srun -n 68 -c 1 --cpu_bind=cores python cnn.py
date
