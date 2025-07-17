#!/bin/bash
#FLUX: --job-name=hairy-cupcake-0562
#FLUX: -n=18
#FLUX: --queue=gpu
#FLUX: -t=129600
#FLUX: --urgency=16

python train_1.py --gpu 0
python train_5.py --gpu 0
