#!/bin/bash
#FLUX: --job-name=LipNet
#FLUX: --queue=standard
#FLUX: -t=864000
#FLUX: --urgency=16

module load DL-Conda_3.7
source /home/apps/DL/DL-CondaPy3.7/bin/activate torch
cd $SLURM_SUBMIT_DIR
CUDA_VISIBLE_DEVICES=0,1 python train_ddp.py
