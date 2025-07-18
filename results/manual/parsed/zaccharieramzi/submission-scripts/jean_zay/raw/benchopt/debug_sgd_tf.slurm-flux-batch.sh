#!/bin/bash
#FLUX: --job-name=benchopt_run_debug
#FLUX: -c=10
#FLUX: -t=600
#FLUX: --urgency=16

export PYTHONUSERBASE='$WORK/.local_torch'
export PATH='$WORK/.local_torch/bin:$PATH'
export XLA_FLAGS='--xla_gpu_cuda_data_dir=/gpfslocalsys/cuda/11.2'

module purge
export PYTHONUSERBASE=$WORK/.local_torch
module load pytorch-gpu/py3/1.10.1
export PATH=$WORK/.local_torch/bin:$PATH
export XLA_FLAGS="--xla_gpu_cuda_data_dir=/gpfslocalsys/cuda/11.2"
cd $WORK/benchmark_resnet_classif
BASIC_CMD="benchopt run ."
BASIC_CMD="$BASIC_CMD -o *18 -d cifar[*,random_state=42,with_validation=False] -r 1 -n 1 --timeout 3600 -f"
ARGS="sgd-tf[batch_size=128,data_aug=False,*,lr_schedule=None,*,nesterov=False,weight_decay=0.0]"
$BASIC_CMD $ARGS
