#!/bin/bash
#FLUX: --job-name=usis
#FLUX: -c=2
#FLUX: -t=428400
#FLUX: --urgency=16

conda activate /anaconda3/envs/myenv
python train.py --name usis_wavelet --dataset_mode cityscapes --gpu_ids 0 \
--dataroot /data/public/cityscapes --batch_size 1  \
--netDu wavelet \
--model_supervision 0 --netG wavelet --channels_G 16
