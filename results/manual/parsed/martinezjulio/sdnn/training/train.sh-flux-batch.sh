#!/bin/bash
#FLUX: --job-name=vgg_afd
#FLUX: --queue=nklab
#FLUX: -t=601200
#FLUX: --priority=16

CONFIG_FILE='./configs/vgg/face_AFD_matched_seed.yaml'
SCRIPT=./train_new.py
hostname
date
echo "Sourcing conda..."
source /mindhive/nklab4/users/kdobs/anaconda3/bin/activate
date
echo "Activating conda env..."
conda activate torch-gpu-dev
date
echo "Running python script..."
CUDA_VISIBLE_DEVICES=0 python $SCRIPT --config_file $CONFIG_FILE --num_epochs 201 --read_seed 1 --maxout True --save_freq 10 --valid_freq 1 --use_scheduler "True" --pretrained "False" # --custom_learning_rate 0.0001
date
echo "Job completed"
