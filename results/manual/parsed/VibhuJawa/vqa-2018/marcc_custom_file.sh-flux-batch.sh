#!/bin/bash
#FLUX: --job-name=stinky-diablo-5777
#FLUX: --urgency=16

module load cuda/9.0
python test.py
python main1.py --num-workers 8 --batch-size 128 --epochs 30 --lr 1e-6
