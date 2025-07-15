#!/bin/bash
#FLUX: --job-name=chunky-destiny-3741
#FLUX: --priority=16

module load anaconda/py3
source /data/jliang12/zzhou82/environments/pytorch/bin/activate
nvidia-smi
python -W ignore genesis_lung.py --data $1 --weights $2
