#!/bin/bash
#FLUX: --job-name=mf_thin_spiral_train
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --urgency=16

cd /storage/homefs/ch19g182/Python/Denoising-Normalizing-Flow-master/experiments
nvcc --version
nvidia-smi
python train.py  -c configs/train_mf_thin_spiral.config
