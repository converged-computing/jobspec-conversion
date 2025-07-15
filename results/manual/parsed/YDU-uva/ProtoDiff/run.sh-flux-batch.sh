#!/bin/bash
#FLUX: --job-name=moolicious-peas-8055
#FLUX: -t=129600
#FLUX: --priority=16

python train_1.py --gpu 0
python train_5.py --gpu 0
