#!/bin/bash
#FLUX: --job-name=sticky-train-8233
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python KITTI-MOTS-taskc.py -p mlow
