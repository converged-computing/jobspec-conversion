#!/bin/bash
#FLUX: --job-name=g_ado
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --urgency=16

singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install -U -e simglucose_local # Gym will also be installed
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime python g_training_adolescent.py
