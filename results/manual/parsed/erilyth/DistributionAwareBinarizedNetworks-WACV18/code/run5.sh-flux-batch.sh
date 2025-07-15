#!/bin/bash
#FLUX: --job-name=angry-pot-8457
#FLUX: -t=172800
#FLUX: --priority=16

module add cuda/8.0
module add cudnn/7-cuda-8.0
srun bash clean.sh; CUDA_VISIBLE_DEVICES=0 python3 main.py --dataset='sketchyrecognition' --data_dir='/ssd_scratch/cvit/' --nClasses=125 --workers=4 --epochs=400 --batch-size=256 --testbatchsize=16 --learningratescheduler='decayschedular' --decayinterval=50 --decaylevel=2 --optimType='adam' --nesterov --tenCrop --maxlr=0.0005 --minlr=0.00001 --weightDecay=0 --binaryWeight --binStart=2 --binEnd=7 --model_def='sketchanetfbin' --inpsize=225 --name='sketchy_sketchanetfbin_dualbin_oldactiv' | tee "textlogs/sketchy_sketchanetfbin_dualbin_oldactiv.txt" &
srun bash clean.sh; CUDA_VISIBLE_DEVICES=1 python3 main.py --dataset='sketchyrecognition' --data_dir='/ssd_scratch/cvit/' --nClasses=125 --workers=4 --epochs=400 --batch-size=128 --testbatchsize=8 --learningratescheduler='decayschedular' --decayinterval=50 --decaylevel=2 --optimType='adam' --nesterov --tenCrop --maxlr=0.0005 --minlr=0.00001 --weightDecay=0 --binaryWeight --binStart=2 --binEnd=100 --model_def='resnetfbin18' --inpsize=224 --name='sketchy_resnetfbin18_dualbin_oldactiv' | tee "textlogs/sketchy_resnetfbin18_dualbin_oldactiv.txt" &
