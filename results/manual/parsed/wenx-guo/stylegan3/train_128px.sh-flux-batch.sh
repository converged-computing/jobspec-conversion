#!/bin/bash
#FLUX: --job-name=stylegan3
#FLUX: -c=48
#FLUX: --exclusive
#FLUX: -t=604800
#FLUX: --urgency=16

ml load anaconda3-2019.03
ml gcc/10.4
ml cuda/11.6.2
cd /home/wg2361/xai-face-model/stylegan3
conda activate stylegan3
python -u train.py --gpus=8 --outdir=/scratch/nklab/projects/face_proj/models/stylegan3/ffhq_128 --cfg=stylegan3-r --data=/scratch/nklab/projects/face_proj/datasets/ffhq_128 --batch=32 --gamma=0.5 --cbase=16384
