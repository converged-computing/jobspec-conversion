#!/bin/bash
#FLUX: --job-name=quirky-fork-7564
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

source activate pytorch_resnet
python_script=$1
job_num=$2
job_type=$3
lr=$4
DEBUG=1 python -u $python_script $job_num $job_type --hidden_size 1000 --num_hidden_layers 6 --lr $lr
