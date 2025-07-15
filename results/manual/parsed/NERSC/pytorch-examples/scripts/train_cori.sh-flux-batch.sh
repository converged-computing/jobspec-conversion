#!/bin/bash
#FLUX: --job-name=carnivorous-bits-7706
#FLUX: --urgency=16

export OMP_NUM_THREADS='32'
export KMP_AFFINITY='granularity=fine,compact,1,0'
export KMP_BLOCKTIME='1'

module load pytorch/v1.5.0
export OMP_NUM_THREADS=32
export KMP_AFFINITY="granularity=fine,compact,1,0"
export KMP_BLOCKTIME=1
srun -l -u python train.py -d mpi $@
