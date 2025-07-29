#!/bin/bash
#FLUX --job-name=nerdy-nunchucks-8403
#FLUX -n=4
#FLUX --queue=mlow
#FLUX --urgency=16

python ../KITTI-MOTS-train-taskb.py -p mlow
