#!/bin/bash
#FLUX: --job-name=___
#FLUX: -n=30
#FLUX: -t=345600
#FLUX: --urgency=16

module load cudnn/7-cuda-10.0
mpiexec -n 3 python3 train_1.py --num_epochs 300 --num_channels 256 --num_steps 32 --warm_up 500000 --batch_size 8
