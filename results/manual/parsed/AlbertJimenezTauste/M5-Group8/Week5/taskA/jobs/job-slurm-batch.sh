#!/bin/bash
#FLUX: --job-name=swampy-staircase-7696
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python ../KITTI-MOTS-eval-MOTS.py -p mhigh
