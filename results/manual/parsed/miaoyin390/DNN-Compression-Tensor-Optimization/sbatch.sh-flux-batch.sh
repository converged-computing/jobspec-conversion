#!/bin/bash
#FLUX: --job-name=frigid-banana-4659
#FLUX: --priority=16

echo 'use bridges-2'
RC=1
n=0
sourceDir=/ocean/projects/asc200010p/czhang82/imagenet_tar/
destDir=$LOCAL/imagenet
while [[ $RC -ne 0 && $n -lt 20 ]]; do
    echo 'copy dataset to' $destDir
    rsync -avP $sourceDir/* $destDir
    RC=$?
    n=$(( $n + 1 ))
    # let n = n + 1
    sleep 10
done
workDir=$(pwd)
cd $destDir
tar -xf train.tar
tar -xf val.tar
cd $workDir
module load cuda/11.1.1
module load cudnn
python -m torch.distributed.launch --nproc_per_node 4 main.py --model tkc_resnet18 --decompose --model-path ./saved_models/resnet18_imagenet_admm_tk_0222-022350_model.pt --ratio 5 --format tk --sched step --decay-epochs 30 --decay-rate 0.2 --lr 0.001 --epochs 100 --save-log --save-model --fp16 --num-workers 6 --distributed
