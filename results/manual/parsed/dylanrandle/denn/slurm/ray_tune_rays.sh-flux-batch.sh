#!/bin/bash
#FLUX: --job-name=lovely-malarkey-3270
#FLUX: --urgency=16

module load gcc/10.2.0-fasrc01
module load Anaconda3/2020.11
source activate denn
cd ../denn
python ray_tune.py --pkey rays --ncpu 48 --nsample 1400
