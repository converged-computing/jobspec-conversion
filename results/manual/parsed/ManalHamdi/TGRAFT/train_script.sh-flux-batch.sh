#!/bin/bash
#FLUX: --job-name=RAFT
#FLUX: -n=4
#FLUX: --urgency=16

module load python/anaconda3
conda activate raft
mkdir -p checkpoints
CUDA_VISIBLE_DEVICES=7
python3 -u train_new.py --name raft-acdc --stage acdc --validation acdc --dataset_folder "/home/kevin/manal/RAFT/datasets/ACDC_processed/" --gpus 0 --num_steps 50 --batch_size 1 --lr 0.0004 --image_size 368 496 --wdecay 0.0001
