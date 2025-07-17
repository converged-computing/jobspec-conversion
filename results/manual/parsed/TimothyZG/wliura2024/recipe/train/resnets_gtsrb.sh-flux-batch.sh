#!/bin/bash
#FLUX: --job-name=muffled-buttface-4188
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
python recipe/train/train_resnet.py -d GTSRB -m Resnet18 -pn GTSRB -o ADAM -n 4 -e 30
python recipe/train/train_resnet.py -d GTSRB -m Resnet50 -pn GTSRB -o ADAM -n 4 -e 30
python recipe/train/train_resnet.py -d GTSRB -m Resnet101 -pn GTSRB -o ADAM -n 4 -e 30
