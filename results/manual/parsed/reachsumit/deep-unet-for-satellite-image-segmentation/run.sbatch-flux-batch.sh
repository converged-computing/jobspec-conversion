#!/bin/bash
#FLUX: --job-name=satellite
#FLUX: --queue=mscagpu
#FLUX: -t=10800
#FLUX: --urgency=16

module load Anaconda3 cuda/8.0
python train_unet.py
python predict.py
