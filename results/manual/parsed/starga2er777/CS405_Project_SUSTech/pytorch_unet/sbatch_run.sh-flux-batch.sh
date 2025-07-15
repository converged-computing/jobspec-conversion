#!/bin/bash
#FLUX: --job-name=Unet
#FLUX: --queue=gpulab02
#FLUX: --priority=16

nvidia-smi
python3 script_train.py --datadir ../datasets/cityscapes --batch_size 4 --num_gpu 1 --losstype segment
