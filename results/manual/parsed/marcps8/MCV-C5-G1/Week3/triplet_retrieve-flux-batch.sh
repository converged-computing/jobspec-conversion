#!/bin/bash
#FLUX: --job-name=carnivorous-dog-9767
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python metric_learning.py --arch-type triplet --process retrieve
