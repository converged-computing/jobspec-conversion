#!/bin/bash
#FLUX --job-name=wobbly-fudge-3540
#FLUX -n=4
#FLUX --queue=mlow
#FLUX --urgency=16

python KITTI-MOTS-taskc.py -p mlow
