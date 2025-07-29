#!/bin/bash
#FLUX: --job-name=boopy-signal-8175
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python ../KITTI-MOTS-evaluate.py -p mhigh
