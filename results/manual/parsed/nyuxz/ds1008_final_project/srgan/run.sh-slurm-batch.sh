#!/bin/bash
#FLUX: --job-name=drqa
#FLUX: -c=2
#FLUX: -t=72000
#FLUX: --urgency=16

module load python3/intel/3.6.3
module load pytorch/python3.6/0.3.0_4
module load cuda/8.0.44
module load cudnn/8.0v5.1
time src/python3 train.py --crop_size 88 --upscale_factor 4 --num_epochs 100
