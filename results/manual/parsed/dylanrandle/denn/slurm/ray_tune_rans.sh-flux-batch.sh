#!/bin/bash
#FLUX: --job-name=ray_tune_rans
#FLUX: -n=48
#FLUX: --queue=test
#FLUX: -t=480
#FLUX: --urgency=16

module load gcc/10.2.0-fasrc01
module load Anaconda3/2020.11
source activate denn
cd ../denn
python ray_tune.py --pkey rans --ncpu 48 --nsample 1000
