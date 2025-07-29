#!/bin/bash
#FLUX: --job-name=adorable-plant-7251
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python MOTS-train.py -p mlow
