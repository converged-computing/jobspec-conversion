#!/bin/bash
#FLUX: --job-name=bumfuzzled-eagle-4690
#FLUX: --urgency=16

export PYTHONUNBUFFERED='TRUE'

lscpu
nvidia-smi
export PYTHONUNBUFFERED=TRUE
module load python/3.11.0 openssl/3.0.0 cuda/11.7.1 cudnn/8.6.0
source ../tensorflow.venv/bin/activate
python3 train_SRWGAN.py --trainnum 600 --epochs 40 --batchsz 4 --gpweight 16.0 --cweight 4 --savemodel True
