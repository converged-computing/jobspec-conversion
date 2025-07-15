#!/bin/bash
#FLUX: --job-name=fugly-salad-4395
#FLUX: --queue=longgpgpu
#FLUX: -t=2592000
#FLUX: --urgency=16

module load pytorch/1.5.1-python-3.7.4
python3 trainers/train_gym_v2.py
