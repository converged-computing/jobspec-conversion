#!/bin/bash
#FLUX: --job-name=lipreading-train
#FLUX: -c=2
#FLUX: --queue=savio2_1080ti
#FLUX: -t=86340
#FLUX: --urgency=16

source deactivate
module purge
module load tensorflow/1.5.0-py35-pip-gpu
module unload cudnn/7.1
module load cudnn/7.0.5
python train_cnn.py
