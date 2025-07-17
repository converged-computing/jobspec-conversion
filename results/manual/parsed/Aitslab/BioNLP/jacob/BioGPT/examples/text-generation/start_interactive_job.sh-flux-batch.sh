#!/bin/bash
#FLUX: --job-name=placid-knife-1989
#FLUX: -t=1800
#FLUX: --urgency=16

export CUDA_LAUNCH_BLOCKING='1'

pwd
nvidia-smi
ml Anaconda/2021.05-nsc1
conda activate biogpt
export CUDA_LAUNCH_BLOCKING=1
python interactive.py --model_dir=../../checkpoints/Pre-trained-BioGPT --data_dir=../../data > jacob_test.txt
