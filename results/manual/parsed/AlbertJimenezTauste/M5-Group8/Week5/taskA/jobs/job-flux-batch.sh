#!/bin/bash
#FLUX --job-name=bricky-latke-0696
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python ../KITTI-MOTS-eval-MOTS.py -p mhigh
