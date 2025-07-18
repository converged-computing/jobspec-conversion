#!/bin/bash
#FLUX: --job-name=cifar_horovod
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export KMP_BLOCKTIME='1'
export KMP_SETTINGS='1'
export KMP_AFFINITY='granularity=fine,compact,1,0'
export OMP_NUM_THREADS='66'
export PYTHON='python'
export WORK_DIR='`pwd`/..'
export TF_SCRIPT='${WORK_DIR}/resnet_cifar_main.py'
export TF_EVAL_SCRIPT='${WORK_DIR}/resnet_cifar_eval.py'
export DATASET='cifar10'
export TF_FLAGS=''
export TF_EVAL_FLAGS=''

module load tensorflow/intel-head-MKL-DNN
export KMP_BLOCKTIME=1
export KMP_SETTINGS=1
export KMP_AFFINITY=granularity=fine,compact,1,0
export OMP_NUM_THREADS=66
export PYTHON=python
export WORK_DIR=`pwd`/..
export TF_SCRIPT="${WORK_DIR}/resnet_cifar_main.py"
export TF_EVAL_SCRIPT="${WORK_DIR}/resnet_cifar_eval.py"
export DATASET=cifar10
if [ -z $3 ]; then
  let BATCH_SIZE=128/${SLURM_JOB_NUM_NODES}
else
  BATCH_SIZE=$3
fi
export BATCH_SIZE
export TF_FLAGS="
  --train_data_path=${SCRATCH}/data \
  --log_root=./tmp/resnet_model \
  --train_dir=./tmp/resnet_model/train \
  --dataset=${DATASET} \
  --num_gpus=0 \
  --batch_size=${BATCH_SIZE} \
  --sync_replicas=True \
  --train_steps=80000 \
  --num_intra_threads=66 \
  --num_inter_threads=3 \
  --data_format=channels_last
"
export TF_EVAL_FLAGS="
  --eval_data_path=${SCRATCH}/data/cifar-10-batches-bin/test_batch* \
  --log_root=./tmp/resnet_model \
  --eval_dir=./tmp/resnet_model/test \
  --dataset=${DATASET} \
  --mode=eval \
  --num_gpus=0 \
  --num_intra_threads=66 \
  --num_inter_threads=3 \
  --data_format=channels_last
"
if [ -z $1 ]; then
  export TF_NUM_PS=$1 # 1
else
  export TF_NUM_PS=1
fi
if [ -z $2 ]; then
  let TF_NUM_WORKERS=${SLURM_JOB_NUM_NODES}-1
  export TF_NUM_WORKERS
else
  TF_NUM_WORKERS=$2
  export TF_NUM_WORKERS
fi
DIST_TF_LAUNCHER_SCRIPT=run_dist_train_eval_daint.sh
DIST_TF_LAUNCHER_DIR=./logs/$1-ps-$2-wk-batch-$3-${DATASET}-log #$SCRATCH/run_dist_tf_daint_directory
if [ $4 ]; then
  echo "remove previous checkpoints"
  rm -rf $DIST_TF_LAUNCHER_DIR
else
  rm -rf $DIST_TF_LAUNCHER_DIR/*.log
  rm -rf $DIST_TF_LAUNCHER_DIR/*.sh
fi
mkdir -p $DIST_TF_LAUNCHER_DIR
cp ${DIST_TF_LAUNCHER_SCRIPT} $DIST_TF_LAUNCHER_DIR
cd $DIST_TF_LAUNCHER_DIR
./${DIST_TF_LAUNCHER_SCRIPT}
