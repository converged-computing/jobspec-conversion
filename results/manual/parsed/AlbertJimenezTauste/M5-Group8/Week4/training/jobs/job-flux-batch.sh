#!/bin/bash
#FLUX --job-name=carnivorous-knife-8261
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python ../KITTI-MOTS-train.py -p mhigh
