#!/bin/bash
#FLUX: --job-name="emnlp_baseline"
#FLUX: -t=21540
#FLUX: --priority=16

echo "loading"
module load python/3.6.1
module load cudnn/v6
module load cuda/8.0.61
module load tensorflow/1.5.0-py36-gpu
echo "loaded"
python learn.py --num $1
