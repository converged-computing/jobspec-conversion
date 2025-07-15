#!/bin/bash
#FLUX: --job-name=chunky-nunchucks-2135
#FLUX: --queue=gpu
#FLUX: --priority=16

export PYTHONUNBUFFERED='TRUE'

module load any/python/3.8.3-conda
git log -n 1 --pretty=format:"Commit: %H %s%n"
conda activate hypatia
export PYTHONUNBUFFERED=TRUE
python training.py --total_epochs=2 --batch_size=32 --learning_rate=0.0001 --save_time=3600 --no_random_degradation
