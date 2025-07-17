#!/bin/bash
#FLUX: --job-name=creamy-cherry-9998
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python evaluation.py --model-index 1
