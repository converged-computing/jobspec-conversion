#!/bin/bash
#FLUX: --job-name=rainbow-animal-0055
#FLUX: -n=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

python -u train_unet_hist.py -g 0 -b 4 -d BCSS -m CENet -f 2
