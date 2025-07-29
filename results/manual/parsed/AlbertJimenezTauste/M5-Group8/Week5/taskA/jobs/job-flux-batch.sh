#!/bin/bash
#FLUX --job-name=joyous-gato-5231
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python ../KITTI-MOTS-eval-MOTS.py -p mhigh
