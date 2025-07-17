#!/bin/bash
#FLUX: --job-name=psycho-nalgas-3064
#FLUX: -N=4
#FLUX: -n=24
#FLUX: --queue=gpu
#FLUX: -t=57600
#FLUX: --urgency=16

module load cuda/9.0
python test.py
python main1.py --num-workers 8 --batch-size 128 --epochs 30 --lr 1e-6
