#!/bin/bash
#FLUX: --job-name=medical
#FLUX: -c=4
#FLUX: -t=601200
#FLUX: --urgency=16

pyenv activate venv
module load cuda
CUDA_VISIBLE_DEVICES=0 python train.py --name Wavelet_MRI_nomask --dataset_mode medicals --gpu_ids 0 \
--dataroot /misc/data/private/autoPET/CT_MR  \
--batch_size 4 --model_supervision 0  \
--Du_patch_size 32 --netDu wavelet  \
--netG 9 --channels_G 16   \
--num_epochs 500
