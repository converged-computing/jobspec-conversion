#!/bin/bash
#FLUX: --job-name=lovable-sundae-8595
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python MOTS-train.py -p mlow
