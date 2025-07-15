#!/bin/bash
#FLUX: --job-name=LipNet-test  #change name of ur job
#FLUX: --queue=gpu  #there are various partition. U can change various GPUs
#FLUX: -t=3600
#FLUX: --priority=16

module load DL-Conda_3.7
source /home/apps/DL/DL-CondaPy3.7/bin/activate torch
cd $SLURM_SUBMIT_DIR
CUDA_VISIBLE_DEVICES=0 python test.py
