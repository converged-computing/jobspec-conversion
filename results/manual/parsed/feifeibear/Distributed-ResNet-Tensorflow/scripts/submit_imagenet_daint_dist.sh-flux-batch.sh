#!/bin/bash
#FLUX: --job-name=imagenet
#FLUX: -N=9
#FLUX: -t=86400
#FLUX: --priority=16

export WORKON_HOME='~/Envs'
export WORK_DIR='`pwd`/..'
export TF_SCRIPT='${WORK_DIR}/resnet_imagenet_main.py'
export TF_EVAL_SCRIPT='${WORK_DIR}/resnet_imagenet_eval.py'
export DATASET='imagenet'
export TF_FLAGS=''
export TF_EVAL_FLAGS=''
export TF_NUM_PS='$1 # 1'
export TF_NUM_WORKERS='$2 # $SLURM_JOB_NUM_NODES'

module use /apps/daint/UES/6.0.UP02/sandbox-dl/modules/all
module load daint-gpu
module load TensorFlow/1.3.0-CrayGNU-17.08-cuda-8.0-python3
export WORKON_HOME=~/Envs
source $WORKON_HOME/tf-daint/bin/activate
export WORK_DIR=`pwd`/..
export TF_SCRIPT="${WORK_DIR}/resnet_imagenet_main.py"
export TF_EVAL_SCRIPT="${WORK_DIR}/resnet_imagenet_eval.py"
export DATASET=imagenet
export TF_FLAGS="
  --train_data_path=${SCRATCH}/data/imagenet \
  --log_root=./tmp/resnet_model \
  --train_dir=./tmp/resnet_model/train \
  --dataset=${DATASET} \
  --mode=train \
  --num_gpus=1 \
  --batch_size=16 \
  --sync_replicas=True \
  --train_steps=112600 \
  --num_epochs=90
"
export TF_EVAL_FLAGS="
  --eval_data_path=${SCRATCH}/data/imagenet \
  --log_root=./tmp/resnet_model \
  --eval_dir=./tmp/resnet_model/test \
  --dataset=${DATASET} \
  --mode=eval \
  --num_gpus=1 \
  --num_epochs=3000
"
export TF_NUM_PS=$1 # 1
export TF_NUM_WORKERS=$2 # $SLURM_JOB_NUM_NODES
DIST_TF_LAUNCHER_DIR=./logs/$1-ps-$2-wk-${DATASET}-log #$SCRATCH/run_dist_tf_daint_directory
DIST_TF_LAUNCHER_SCRIPT=run_dist_train_eval_daint.sh
mkdir -p $DIST_TF_LAUNCHER_DIR
rm -rf $DIST_TF_LAUNCHER_DIR/*.log
rm -rf $DIST_TF_LAUNCHER_DIR/*.sh
cp $DIST_TF_LAUNCHER_SCRIPT $DIST_TF_LAUNCHER_DIR
cd $DIST_TF_LAUNCHER_DIR
./$DIST_TF_LAUNCHER_SCRIPT
deactivate
