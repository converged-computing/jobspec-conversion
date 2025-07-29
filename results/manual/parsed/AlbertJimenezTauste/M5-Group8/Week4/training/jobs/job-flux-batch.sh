#!/bin/bash
#FLUX --job-name=blue-pancake-9085
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python ../KITTI-MOTS-train.py -p mhigh
