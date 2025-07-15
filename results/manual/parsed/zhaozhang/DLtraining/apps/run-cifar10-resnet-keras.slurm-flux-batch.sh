#!/bin/bash
#FLUX: --job-name=spicy-cat-6507
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
mkdir -p /tmp/keras
cp /home1/apps/keras/data/datasets.tar /tmp/keras/datasets.tar 
tar xf /tmp/keras/datasets.tar -C /tmp/keras
ibrun -np 1 python cifar10_resnet_keras.py
