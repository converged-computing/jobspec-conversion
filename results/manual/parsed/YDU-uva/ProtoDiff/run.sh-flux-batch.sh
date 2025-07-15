#!/bin/bash
#FLUX: --job-name=placid-eagle-0563
#FLUX: -t=129600
#FLUX: --urgency=16

python train_1.py --gpu 0
python train_5.py --gpu 0
