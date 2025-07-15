#!/bin/bash
#FLUX: --job-name=hanky-toaster-6764
#FLUX: -t=172800
#FLUX: --urgency=16

source ~/anaconda3/bin/activate
conda activate DRACO
cd /home/rahulsajnani/research/DRACO-Weakly-Supervised-Dense-Reconstruction-And-Canonicalization-of-Objects/DRACO
CUDA_VISIBLE_DEVICES=0,1,2,3 python main.py
