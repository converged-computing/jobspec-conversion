#!/bin/bash
#FLUX: --job-name=benchopt_run_sgd_torch
#FLUX: -c=10
#FLUX: -t=21600
#FLUX: --urgency=16

export PYTHONUSERBASE='$WORK/.local_torch'
export PATH='$WORK/.local_torch/bin:$PATH'

module purge
export PYTHONUSERBASE=$WORK/.local_torch
module load pytorch-gpu/py3/1.10.1
export PATH=$WORK/.local_torch/bin:$PATH
cd $WORK/benchmark_resnet_classif
BASIC_CMD="benchopt run ."
BASIC_CMD="$BASIC_CMD -o *34 -d cifar[*,random_state=42,with_validation=False] -r 1 -n 200 --timeout 10800 -s"
SOLVER="sgd-torch[batch_size=128,data_aug=True,*,lr_schedule=cosine,momentum=0.9,nesterov=True,weight_decay=0.0005]"
$BASIC_CMD $SOLVER
