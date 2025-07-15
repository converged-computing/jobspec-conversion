#!/bin/bash
#FLUX: --job-name=gassy-pedo-5928
#FLUX: --queue=kilian --gres=gpu:1080ti:2           # Which queue it should run on.
#FLUX: --priority=16

POINT_STYLE=default
NUM_GPUS=2
BATCH_SIZE=$((4 * $NUM_GPUS)) # upto 4 batches per GPU
module rm cuda cudnn
module add cuda/10.0 cudnn/v7.4-cuda-10.0
module list
set -e
cd ../tools
python eval_rcnn_depth.py --cfg_file cfgs/"$POINT_STYLE".yaml --ckpt /home/rq49/PointRCNN_ORI/sdn_fix_sparse/rcnn/checkpoint_epoch_70.pth --batch_size 8 --eval_mode rcnn
