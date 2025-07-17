#!/bin/bash
#FLUX: --job-name=dl-hw2
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

module load GCC/10.2.0
module load CUDA/11.1.1
module load OpenMPI/4.0.5
module load PyTorch/1.10.0
module load Anaconda3/2021.11
module load Anaconda3/2021.11
cd /scratch/user/bhanu/dl_hw2/ResNet
python main.py
