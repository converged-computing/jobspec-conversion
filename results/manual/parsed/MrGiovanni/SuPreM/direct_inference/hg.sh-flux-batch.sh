#!/bin/bash
#FLUX: --job-name=inference
#FLUX: --urgency=16

module load mamba/latest # only for Sol
source activate suprem
pretrainpath=./pretrained_checkpoints/swin_unetr_totalsegmentator_vertebrae.pth
savepath=./AbdomenAtlasDemoPredict
datarootpath=/scratch/zzhou82/2024_0322/AbdomenAtlasDemo
python -W ignore inference.py --save_dir $savepath --checkpoint $pretrainpath --data_root_path $datarootpath --customize
