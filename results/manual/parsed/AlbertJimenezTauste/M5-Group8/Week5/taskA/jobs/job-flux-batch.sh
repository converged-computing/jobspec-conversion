#!/bin/bash
#FLUX: --job-name=muffled-train-8240
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python ../KITTI-MOTS-eval-MOTS.py -p mhigh
