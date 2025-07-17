#!/bin/bash
#FLUX: --job-name=wobbly-muffin-9818
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python ../train_clone.py -p mhigh
