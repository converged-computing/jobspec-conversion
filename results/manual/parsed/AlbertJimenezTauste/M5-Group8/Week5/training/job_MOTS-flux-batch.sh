#!/bin/bash
#FLUX: --job-name=sticky-staircase-2492
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python MOTS-train.py -p mlow
