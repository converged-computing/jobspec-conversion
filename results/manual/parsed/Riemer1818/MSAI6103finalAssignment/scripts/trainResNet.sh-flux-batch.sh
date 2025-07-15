#!/bin/bash
#FLUX: --job-name=MyJob
#FLUX: --queue=SCSEGPU_M1
#FLUX: --urgency=16

module load anaconda3/23.5.2
eval "$(conda shell.bash hook)"
conda activate pytorch-CycleGAN-and-pix2pix
python train.py --dataroot ./datasets/cityscapes --name cityscapes_pix2pix_ResNet --model pix2pix --direction BtoA --display_id -1 --loss resnet --save_epoch_freq 50
