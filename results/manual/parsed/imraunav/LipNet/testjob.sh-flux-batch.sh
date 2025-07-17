#!/bin/bash
#FLUX: --job-name=LipNet-test
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load DL-Conda_3.7
source /home/apps/DL/DL-CondaPy3.7/bin/activate torch
cd $SLURM_SUBMIT_DIR
CUDA_VISIBLE_DEVICES=0 python test.py
