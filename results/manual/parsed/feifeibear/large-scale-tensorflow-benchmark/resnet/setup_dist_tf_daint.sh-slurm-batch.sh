#!/bin/bash
#FLUX: --job-name=dist_deepMNIST
#FLUX: -N=9
#FLUX: -t=3600
#FLUX: --urgency=16

export WORKON_HOME='~/Envs'
export TF_SCRIPT='/scratch/snx3000/youyang9/fjr/tf_workspace/large-scale-tensorflow-benchmark/resnet/resnet_main.py'
export TF_EVAL_SCRIPT='/scratch/snx3000/youyang9/fjr/tf_workspace/large-scale-tensorflow-benchmark/resnet/resnet_eval.py'
export WORK_DIR='/scratch/snx3000/youyang9/fjr/tf_workspace/large-scale-tensorflow-benchmark/resnet'
export DATASET='cifar10'
export TF_FLAGS=''
export TF_EVAL_FLAGS=''
export TF_NUM_PS='$1 # 1'
export TF_NUM_WORKERS='$2 # $SLURM_JOB_NUM_NODES'

module use /apps/daint/UES/6.0.UP02/sandbox-dl/modules/all
module load daint-gpu
module load TensorFlow/1.2.1-CrayGNU-17.08-cuda-8.0-python3
export WORKON_HOME=~/Envs
source $WORKON_HOME/tf-daint/bin/activate
export TF_SCRIPT="/scratch/snx3000/youyang9/fjr/tf_workspace/large-scale-tensorflow-benchmark/resnet/resnet_main.py"
export TF_EVAL_SCRIPT="/scratch/snx3000/youyang9/fjr/tf_workspace/large-scale-tensorflow-benchmark/resnet/resnet_eval.py"
export WORK_DIR="/scratch/snx3000/youyang9/fjr/tf_workspace/large-scale-tensorflow-benchmark/resnet"
export DATASET=cifar10
export TF_FLAGS="
  --train_data_path=${WORK_DIR}/cifar-10-batches-bin/data_batch* \
  --log_root=./tmp/resnet_model \
  --train_dir=./tmp/resnet_model/train \
  --dataset=${DATASET} \
  --num_gpus=1 \
  --batch_size=16 \
  --sync_replicas=True \
  --train_steps=80000
"
export TF_EVAL_FLAGS="
  --eval_data_path=${WORK_DIR}/cifar-10-batches-bin/test_batch* \
  --log_root=./tmp/resnet_model \
  --train_dir=./tmp/resnet_model/test \
  --dataset=${DATASET} \
  --mode=eval \
  --num_gpus=1
"
export TF_NUM_PS=$1 # 1
export TF_NUM_WORKERS=$2 # $SLURM_JOB_NUM_NODES
DIST_TF_LAUNCHER_DIR=./logs/$1-ps-$2-wk-${DATASET}-log #$SCRATCH/run_dist_tf_daint_directory
rm -rf $DIST_TF_LAUNCHER_DIR
mkdir -p $DIST_TF_LAUNCHER_DIR
cp run_dist_tf_eval_daint.sh $DIST_TF_LAUNCHER_DIR
cd $DIST_TF_LAUNCHER_DIR
./run_dist_tf_eval_daint.sh
deactivate
