#!/bin/bash
#FLUX: --job-name=chocolate-pot-1734
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python ../KITTI-MOTS-train.py -p mhigh
