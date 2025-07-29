#!/bin/bash
#FLUX: --job-name=IoU
#FLUX: -c=10
#FLUX: -t=71940
#FLUX: --urgency=16

module purge
conda deactivate
module load pytorch-gpu/py3/1.7.1
CUDA_VISIBLE_DEVICES=0 python $WORK/code/semantic-segmentation/demo_folder.py --snapshot $WORK/code/semantic-segmentation/pretrained_models/kitti_best.pth
