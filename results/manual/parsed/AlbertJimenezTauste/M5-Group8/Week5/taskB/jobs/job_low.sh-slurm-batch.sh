#!/bin/bash
#FLUX: --job-name=cowy-salad-0414
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../KITTI-MOTS-train-taskb.py -p mlow
