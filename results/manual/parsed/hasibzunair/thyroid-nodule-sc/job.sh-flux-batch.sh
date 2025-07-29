#!/bin/bash
#FLUX --job-name=frigid-mango-5889
#FLUX -t=600
#FLUX --urgency=16

module load cuda cudnn 
nvidia-smi
source /home/hasib/projects/def-abhamza/hasib/envs/gpu/bin/activate
cd scripts
python train_seg.py
