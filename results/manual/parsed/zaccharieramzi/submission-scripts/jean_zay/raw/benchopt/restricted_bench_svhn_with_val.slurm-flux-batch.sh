#!/bin/bash
#FLUX: --job-name=restricted_benchopt_run
#FLUX: -c=10
#FLUX: -t=7200
#FLUX: --urgency=16

export PYTHONUSERBASE='$WORK/.local_torch'
export PATH='$WORK/.local_torch/bin:$PATH'

module purge
export PYTHONUSERBASE=$WORK/.local_torch
module load pytorch-gpu/py3/1.10.1
export PATH=$WORK/.local_torch/bin:$PATH
cd $WORK/benchmark_resnet_classif
i=0
for random_state in {42,43,44,45,46}; do
    BASIC_CMD="benchopt run ."
    BASIC_CMD="$BASIC_CMD -o *18 -d svhn[*,random_state=${random_state},with_validation=True] -r 1 -n 200 --timeout 10800"
    BASIC_CMD="$BASIC_CMD --no-plot -s"
    model="sgd-torch[batch_size=128"
    # sgd with data aug + momentum + cosine + wd
    opt[$i]="$BASIC_CMD ${model},data_aug=True,*,lr_schedule=cosine,momentum=0.9,nesterov=False,weight_decay=0.0005]"
    i=$((i+1))
    # sgd with data aug + momentum + step + wd
    opt[$i]="$BASIC_CMD ${model},data_aug=True,*,lr_schedule=step,momentum=0.9,nesterov=False,weight_decay=0.0005]"
    i=$((i+1))
done
${opt[$SLURM_ARRAY_TASK_ID]}
