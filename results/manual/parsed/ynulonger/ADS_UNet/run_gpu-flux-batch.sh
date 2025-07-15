#!/bin/bash
#FLUX: --job-name=faux-squidward-1906
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

python -u train_unet_hist.py -g 0 -b 4 -d BCSS -m CENet -f 2
