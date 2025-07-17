#!/bin/bash
#FLUX: --job-name=train
#FLUX: -n=4
#FLUX: --queue=kilian
#FLUX: -t=432000
#FLUX: --urgency=16

POINT_STYLE=default
NUM_GPUS=2
BATCH_SIZE=$((4 * $NUM_GPUS)) # upto 4 batches per GPU
module rm cuda cudnn
module add cuda/10.0 cudnn/v7.4-cuda-10.0
module list
set -e
cd ../tools
python train_rcnn_depth.py --gt_database "" --cfg_file cfgs/"$POINT_STYLE".yaml --batch_size 4 --workers 8 --train_mode end2end --ckpt_save_interval 2 --epochs 300 --mgpus
python eval_rcnn.py --cfg_file cfgs/"$POINT_STYLE".yaml --ckpt ../output/rcnn/"$POINT_STYLE"/ckpt/checkpoint_epoch_70.pth --batch_size 4 --eval_mode rcnn --points_style "$POINT_STYLE"
