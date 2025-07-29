#!/bin/bash
#SBATCH --job-name=Cifar10-1node
#SBATCH --account=Intel-TensorFlow
#SBATCH --output=Cifar10-1node.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=normal

export OMP_NUM_THREADS='64'
export KMP_BLOCKTIME='0'
export KMP_SETTINGS='1'
export KMP_AFFINITY='granularity=fine,verbose,compact,1,0'

export OMP_NUM_THREADS=64
export KMP_BLOCKTIME=0
export KMP_SETTINGS=1
export KMP_AFFINITY=granularity=fine,verbose,compact,1,0
module load phdf5
mkdir -p /dev/shm/keras
cp /home1/apps/keras/data/datasets.tar /dev/shm/keras/datasets.tar 
tar xf /dev/shm/keras/datasets.tar -C /dev/shm/keras
ibrun -np 1 python cifar10_resnet_keras.py
