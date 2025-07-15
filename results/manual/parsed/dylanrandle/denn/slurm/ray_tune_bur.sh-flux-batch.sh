#!/bin/bash
#FLUX: --job-name=bricky-parsnip-0952
#FLUX: --priority=16

module load gcc/10.2.0-fasrc01
module load Anaconda3/2020.11
source activate denn
cd ../denn
python ray_tune.py --pkey bur --ncpu 48 --nsample 2000
