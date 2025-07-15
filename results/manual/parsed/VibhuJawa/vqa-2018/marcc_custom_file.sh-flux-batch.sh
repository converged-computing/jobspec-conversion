#!/bin/bash
#FLUX: --job-name=chocolate-bicycle-9834
#FLUX: --priority=16

module load cuda/9.0
python test.py
python main1.py --num-workers 8 --batch-size 128 --epochs 30 --lr 1e-6
