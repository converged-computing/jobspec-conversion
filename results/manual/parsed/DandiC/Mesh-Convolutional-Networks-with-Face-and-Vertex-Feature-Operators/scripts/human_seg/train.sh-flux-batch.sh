#!/bin/bash
#FLUX: --job-name=HSeg_original
#FLUX: --queue=gpu
#FLUX: --priority=16

enable_lmod
module load python/3.6
module load cuda/9.2
module load pytorch/1.0
python train.py \
--dataroot datasets/human_seg \
--name human_seg_original \
--arch meshunet \
--dataset_mode segmentation \
--ncf 32 64 128 256 \
--ninput_edges 2280 \
--pool_res 1800 1350 600 \
--resblocks 3 \
--batch_size 12 \
--lr 0.001 \
--num_aug 20 \
--slide_verts 0.2 \
