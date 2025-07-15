#!/bin/bash
#FLUX: --job-name=fugly-general-4000
#FLUX: -t=86400
#FLUX: --priority=16

NAME=$1
SEED=$2
module load conda/py3-latest 
module load cuda/9.0
source activate py3venv
source activate ban
python train.py --clevr-dir clevr --model $NAME --seed $2 | tee $NAME-$SEED.log
