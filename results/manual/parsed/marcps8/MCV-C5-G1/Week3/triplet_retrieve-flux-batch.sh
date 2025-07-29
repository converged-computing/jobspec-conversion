#!/bin/bash
#FLUX --job-name=crusty-dog-6352
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python metric_learning.py --arch-type triplet --process retrieve
