#!/bin/bash
#FLUX: --job-name=test1
#FLUX: --queue=RTX3090
#FLUX: -t=172800
#FLUX: --urgency=16

module load spack
module add cuda-11.4.2-gcc-11.2.0-rxy4qhm            # 载入 CUDA 9.0 模块
module add cudnn-8.2.4.15-11.4-gcc-11.2.0-a6q32ad
module add gcc/11.2.0  
module add anaconda           # 载入 anaconda 模块
source ~/.bashrc
conda activate commplax
python simulation.py  --seed 1231 --dz 0.032  --power 0 3 -3  --Rs 36e9 --freqspace 50e9 --Nbits 40000 --path /home/xiaoxinyu/data/0912train_36G_dz32m
