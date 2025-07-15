#!/bin/bash
#FLUX: --job-name=moolicious-poodle-0213
#FLUX: --priority=16

source ~/.bashrc
cd /hpc/data/home/bme/zhangzb1/Kaggle/HAT/hat
conda activate trans
nvidia-smi
python train.py -opt /hpc/data/home/bme/zhangzb1/Kaggle/HAT/options/train/train_HAT-L_SRx4_scratch_SR360_0318.yml
