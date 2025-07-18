#!/bin/bash
#FLUX: --job-name=fat-chair-8135
#FLUX: -n=10
#FLUX: -t=172800
#FLUX: --urgency=16

idx="$1"
nohup python -m visdom.server > nohup_visdom_${idx}.out 2>&1 &
python train.py --dataroot /home/pz1/datasets/fss/FS2K_data/train/photo/ --checkpoints_dir checkpoints --name ckpt_${idx} \
--use_local --discriminator_local --niter 150 --niter_decay 0 --save_epoch_freq 1
nvidia-smi
hostname
