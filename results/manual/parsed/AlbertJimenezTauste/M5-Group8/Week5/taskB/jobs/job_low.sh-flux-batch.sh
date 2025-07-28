#!/bin/bash
#FLUX: --job-name=boopy-lemon-8512
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../KITTI-MOTS-train-taskb.py -p mlow
