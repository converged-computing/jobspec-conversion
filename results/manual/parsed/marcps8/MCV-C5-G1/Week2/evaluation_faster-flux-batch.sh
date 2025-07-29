#!/bin/bash
#FLUX --job-name=fugly-salad-1541
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python evaluation.py --model-index 1
