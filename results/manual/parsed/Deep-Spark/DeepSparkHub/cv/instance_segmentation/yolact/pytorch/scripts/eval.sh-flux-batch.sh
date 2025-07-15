#!/bin/bash
#FLUX: --job-name=tart-puppy-0895
#FLUX: --priority=16

module load python/3.6.4_gcc5_np1.14.5
module load cuda/9.0
cd $SCRATCH/yolact
python3 eval.py --trained_model=$1 --no_bar $2 > logs/eval/$(basename -- $1).log 2>&1
