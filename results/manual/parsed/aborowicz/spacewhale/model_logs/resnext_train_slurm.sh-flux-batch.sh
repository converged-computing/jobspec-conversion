#!/bin/bash
#FLUX: --job-name=sat_training2
#FLUX: -n=28
#FLUX: -t=28800
#FLUX: --urgency=16

pwd
module load shared
module load anaconda/3
module load cuda91/toolkit/9.1
cd ../../..
pwd
source activate ./space_env
cd git_spacewhale/spacewhale
date
python training_tester_weighted.py --name resnext_full_air --model resneXt --data_dir ../../whale/tiled_air32/full_air  --epochs 24
date
