#!/bin/bash
#FLUX: --job-name=persnickety-poo-0964
#FLUX: --queue=sbel_cmg
#FLUX: -t=345660
#FLUX: --urgency=16

conda activate keras
module load cuda/10.0
python train_resnet50.py --dataset ../data --savedResults saved --trainingLog logs 
