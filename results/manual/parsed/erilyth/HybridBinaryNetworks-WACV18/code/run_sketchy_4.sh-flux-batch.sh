#!/bin/bash
#FLUX: --job-name=angry-banana-8482
#FLUX: -t=172800
#FLUX: --urgency=16

module add cuda/8.0
module add cudnn/7-cuda-8.0
array[0]=`echo $CUDA_VISIBLE_DEVICES | cut -d"," -f1`
array[1]=`echo $CUDA_VISIBLE_DEVICES | cut -d"," -f2`
array[2]=`echo $CUDA_VISIBLE_DEVICES | cut -d"," -f3`
srun bash clean.sh; CUDA_VISIBLE_DEVICES="${array[0]}" python3 main.py --dataset='sketchyrecognition' --data_dir='../data/' --nClasses=125 --workers=4 --epochs=400 --batch-size=128 --testbatchsize=4 --learningratescheduler='decayscheduler' --decayinterval=40 --decaylevel=2 --optimType='adam' --nesterov --tenCrop --maxlr=0.002 --minlr=0.00005 --weightDecay=0 --model_def='squeezenet' --name='sketchy_squeezenet' | tee "textlogs/sketchy_squeezenet.txt" &
srun bash clean.sh; CUDA_VISIBLE_DEVICES="${array[1]}" python3 main.py --dataset='sketchyrecognition' --data_dir='../data/' --nClasses=125 --workers=4 --epochs=400 --batch-size=128 --testbatchsize=4 --learningratescheduler='decayscheduler' --decayinterval=40 --decaylevel=2 --optimType='adam' --nesterov --tenCrop --maxlr=0.002 --minlr=0.00005 --weightDecay=0 --binaryWeight --binStart=2 --binEnd=100 --model_def='squeezenetwbin' --name='sketchy_squeezenetwbin' | tee "textlogs/sketchy_squeezenetwbin.txt" &
srun bash clean.sh; CUDA_VISIBLE_DEVICES="${array[2]}" python3 main.py --dataset='sketchyrecognition' --data_dir='../data/' --nClasses=125 --workers=4 --epochs=400 --batch-size=128 --testbatchsize=4 --learningratescheduler='decayscheduler' --decayinterval=40 --decaylevel=2 --optimType='adam' --nesterov --tenCrop --maxlr=0.002 --minlr=0.00005 --weightDecay=0 --binaryWeight --binStart=2 --binEnd=100 --model_def='squeezenetfbin' --name='sketchy_squeezenetfbin' | tee "textlogs/sketchy_squeezenetfbin.txt"
