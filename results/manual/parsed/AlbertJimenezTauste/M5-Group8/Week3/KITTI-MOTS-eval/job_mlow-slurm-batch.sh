#!/bin/bash
#FLUX: --job-name=butterscotch-pancake-6838
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python KITTI-MOTS-taskc.py -p mlow
