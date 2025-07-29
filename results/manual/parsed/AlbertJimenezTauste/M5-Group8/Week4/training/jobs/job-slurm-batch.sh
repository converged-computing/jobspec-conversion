#!/bin/bash
#FLUX: --job-name=crusty-peanut-butter-3769
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python ../KITTI-MOTS-train.py -p mhigh
