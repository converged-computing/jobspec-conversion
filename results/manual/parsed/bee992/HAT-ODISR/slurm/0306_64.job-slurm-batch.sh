#!/bin/bash
#FLUX: --job-name=0318
#FLUX: -n=8
#FLUX: --queue=bme_gpu
#FLUX: -t=432000
#FLUX: --urgency=16

source ~/.bashrc
cd /hpc/data/home/bme/zhangzb1/Kaggle/HAT/hat
conda activate trans
nvidia-smi
python train.py -opt /hpc/data/home/bme/zhangzb1/Kaggle/HAT/options/train/train_HAT-L_SRx4_scratch_SR360_0318.yml
