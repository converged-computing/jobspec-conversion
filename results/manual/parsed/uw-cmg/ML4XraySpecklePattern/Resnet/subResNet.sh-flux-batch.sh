#!/bin/bash
#FLUX: --job-name=muffled-kitty-6855
#FLUX: --urgency=16

conda activate keras
module load cuda/10.0
python train_resnet50.py --dataset ../data --savedResults saved --trainingLog logs 
