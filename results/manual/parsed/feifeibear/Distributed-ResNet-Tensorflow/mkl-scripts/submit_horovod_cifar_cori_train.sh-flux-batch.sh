#!/bin/bash
#FLUX: --job-name=cifar_horovod
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export KMP_BLOCKTIME='1'
export KMP_SETTINGS='1'
export KMP_AFFINITY='granularity=fine,compact,1,0'
export OMP_NUM_THREADS='66'
export TF_SCRIPT='../resnet_cifar_main_horovod.py'
export DATASET='cifar10'
export LOG_DIR='./logs/horovod_cifar_${DATASET}_${SLURM_JOB_NUM_NODES}_nodes_${BATCH_SIZE}_log'
export TF_FLAGS=''

module load tensorflow/intel-horovod-mpi-head
export KMP_BLOCKTIME=1
export KMP_SETTINGS=1
export KMP_AFFINITY=granularity=fine,compact,1,0
export OMP_NUM_THREADS=66
PYTHON=python
let BATCH_SIZE=128/${SLURM_JOB_NUM_NODES}
export BATCH_SIZE
export TF_SCRIPT="../resnet_cifar_main_horovod.py"
export DATASET=cifar10
export LOG_DIR=./logs/horovod_cifar_${DATASET}_${SLURM_JOB_NUM_NODES}_nodes_${BATCH_SIZE}_log
export TF_FLAGS="
  --use_horovod=True \
  --train_data_path=$SCRATCH/data \
  --log_root=${LOG_DIR}/resnet_model \
  --train_dir=${LOG_DIR}/resnet_model/train \
  --dataset=${DATASET} \
  --num_gpus=0 \
  --batch_size=${BATCH_SIZE} \
  --sync_replicas=True \
  --train_steps=80000 \
  --num_intra_threads=66 \
  --num_inter_threads=3 \
  --data_format=channels_last
"
echo $SLURM_JOB_NUM_NODES
srun -n ${SLURM_JOB_NUM_NODES} -N ${SLURM_JOB_NUM_NODES} -c 272 $PYTHON $TF_SCRIPT $TF_FLAGS
