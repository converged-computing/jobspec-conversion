#!/bin/bash
#FLUX: --job-name=expensive-destiny-1136
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python KITTI-MOTS-taskc.py -p mlow
