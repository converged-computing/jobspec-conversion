#!/bin/bash
#FLUX: --job-name=cil_train
#FLUX: -t=86400
#FLUX: --priority=16

source startup.sh
python train.py --lr 0.0001 --data './data_google/training' --model 'fpn' --epochs 17 --full True --augmentations True
python train.py --lr 0.0001 --data './data/training' --model 'fpn' --epochs 30 --full True --augmentations True --load_model './out/model_best.pth.tar'
python train.py --lr 0.00001 --data './data/training' --model 'fpn' --epochs 30 --full True --augmentations True --load_model './out/model_best.pth.tar'
python submit.py --model 'fpn' --n_samples 50 --threshold 0.35
python mask_to_submission.py
