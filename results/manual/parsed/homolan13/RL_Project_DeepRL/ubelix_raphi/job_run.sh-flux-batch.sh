#!/bin/bash
#FLUX: --job-name=Simglucose DDPG
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=5400
#FLUX: --urgency=16

singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install -U -e simglucose_local # Gym will also be installed
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime python train_ubelix.py
