#!/bin/bash
#FLUX: --job-name=s1245
#FLUX: --queue=gpu
#FLUX: --priority=16

enable_lmod
module load python/3.6
module load cuda/9.2
module load pytorch/1.3
module load wandb
python train.py \
--dataroot datasets/shrec_6 \
--name shrec6_1-2-4-5 \
--ncf 64 128 256 256 \
--pool_res 500 400 300 200 120 \
--norm group \
--resblocks 1 \
--flip_edges 0.2 \
--slide_verts 0.2 \
--num_aug 20 \
--niter_decay 100 \
--gpu_ids 0 \
--ninput_features 500 \
--feat_from face \
--symm_oper 1 2 4 5
