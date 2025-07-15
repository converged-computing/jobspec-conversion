#!/bin/bash
#FLUX: --job-name=angry-egg-7514
#FLUX: --priority=16

export OMP_NUM_THREADS='64'
export KMP_BLOCKTIME='0'
export KMP_SETTINGS='1'
export KMP_AFFINITY='granularity=fine,verbose,compact,1,0'

export OMP_NUM_THREADS=64
export KMP_BLOCKTIME=0
export KMP_SETTINGS=1
export KMP_AFFINITY=granularity=fine,verbose,compact,1,0
module load phdf5
ibrun -np 4 mkdir /dev/shm/keras
/home1/apps/dl-tools/bin/broadcast-mpi.sh /home1/apps/keras/data/datasets.tar /dev/shm/keras/datasets.tar 4
ibrun -np 4 tar xf /dev/shm/keras/datasets.tar -C /dev/shm/keras
ibrun -np 4 python cifar10_resnet_horovod.py
