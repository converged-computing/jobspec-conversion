#!/bin/bash
#FLUX: --job-name=test2
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
python simulation.py  --seed 3214 --dz 0.002  --power 6 -6  --path /home/xiaoxinyu/data/0912test_dz_2m
