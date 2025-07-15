#!/bin/bash
#FLUX: --job-name=angry-animal-5705
#FLUX: --priority=16

module load gcc/10.2.0-fasrc01
module load Anaconda3/2020.11
source activate denn
cd ../denn
python ray_tune.py --pkey burv --loss MSELoss --ncpu 48 --nsample 200
python ray_tune.py --pkey burv --loss L1Loss --ncpu 48 --nsample 200
python ray_tune.py --pkey burv --loss SmoothL1Loss --ncpu 48 --nsample 200
