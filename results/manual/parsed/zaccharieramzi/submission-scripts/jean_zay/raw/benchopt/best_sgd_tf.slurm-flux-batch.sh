#!/bin/bash
#FLUX: --job-name=benchopt_run_best_sgd
#FLUX: -c=10
#FLUX: -t=7200
#FLUX: --priority=16

export PYTHONUSERBASE='$WORK/.local_torch'
export PATH='$WORK/.local_torch/bin:$PATH'
export TMPDIR='$JOBSCRATCH'

module purge
export PYTHONUSERBASE=$WORK/.local_torch
module load pytorch-gpu/py3/1.10.1
export PATH=$WORK/.local_torch/bin:$PATH
export TMPDIR=$JOBSCRATCH
cd $WORK/benchmark_resnet_classif
BASIC_CMD="benchopt run ."
BASIC_CMD="$BASIC_CMD -o *18 -d cifar[*,random_state=42,with_validation=False] -r 1 -n 200 --timeout 10800 -f"
ARGS="sgd-tf[batch_size=128,coupled_weight_decay=0.0005,data_aug=True,*,lr_schedule=cosine,momentum=0.9,nesterov=True]"
$BASIC_CMD $ARGS
