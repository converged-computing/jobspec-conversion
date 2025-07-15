#!/bin/bash
#FLUX: --job-name=LipNet  #change name of ur job
#FLUX: --queue=standard  #there are various partition. U can change various GPUs
#FLUX: -t=864000
#FLUX: --priority=16

module load DL-Conda_3.7
source /home/apps/DL/DL-CondaPy3.7/bin/activate torch
cd $SLURM_SUBMIT_DIR
CUDA_VISIBLE_DEVICES=0,1 python train_ddp.py
