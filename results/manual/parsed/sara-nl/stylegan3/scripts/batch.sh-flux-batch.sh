#!/bin/bash
#FLUX: --job-name=dinosaur-lettuce-1170
#FLUX: -c=72
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

cd ~/NKI/stylegan3/
source load_env.sh
python train.py --outdir=runs --cfg=stylegan3-r --data=/projects/2/managed_datasets/CHESTXRAY/chestxray.zip --gpus=4 --batch=32 --gamma=32 --batch-gpu=4 --tick=1 --metrics=none --snap 5
