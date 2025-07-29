#!/bin/bash
#FLUX --job-name=crunchy-hope-5525
#FLUX -n=4
#FLUX --queue=mlow
#FLUX --urgency=16

python KITTI-MOTS-taskc.py -p mlow
