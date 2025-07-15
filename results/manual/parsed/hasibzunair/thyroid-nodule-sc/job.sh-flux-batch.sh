#!/bin/bash
#FLUX: --job-name=swampy-animal-8546
#FLUX: -t=600
#FLUX: --priority=16

module load cuda cudnn 
nvidia-smi
source /home/hasib/projects/def-abhamza/hasib/envs/gpu/bin/activate
cd scripts
python train_seg.py
