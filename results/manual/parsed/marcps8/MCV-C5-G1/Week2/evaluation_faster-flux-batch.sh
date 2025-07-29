#!/bin/bash
#FLUX --job-name=scruptious-cattywampus-9011
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python evaluation.py --model-index 1
