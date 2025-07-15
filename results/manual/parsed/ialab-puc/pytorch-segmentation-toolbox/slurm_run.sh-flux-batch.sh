#!/bin/bash
#FLUX: --job-name=pspCityscapes
#FLUX: -c=8
#FLUX: --queue=ialab-high
#FLUX: -t=7200
#FLUX: --urgency=16

CS_PATH=$1
MODEL=pspnet
LR=1e-2
WD=5e-4
BS=8
STEPS=40000
GPU_IDS=0
python -m torch.distributed.launch --nproc_per_node=4 train.py --data-dir ${CS_PATH} --model ${MODEL} --random-mirror --random-scale --learning-rate ${LR}  --weight-decay ${WD} --batch-size ${BS} --num-steps ${STEPS} --restore-from ./dataset/MS_DeepLab_resnet_pretrained_init.pth --gpu ${GPU_IDS}
