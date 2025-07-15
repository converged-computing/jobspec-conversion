#!/bin/bash
#FLUX: --job-name=creamy-leader-1205
#FLUX: --urgency=16

alias ll='ls -al'  # 快捷键
module load anaconda/anaconda3-2022.10  # 加载conda
module load cuda/11.1.0  # 加载cuda
module load gcc-11
source activate DiffusionVID  # 激活环境
which pip
which pip
pip list
