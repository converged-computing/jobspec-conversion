#!/bin/bash
#FLUX: --job-name=expressive-cattywampus-2650
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../KITTI-MOTS-train-taskb.py -p mlow
