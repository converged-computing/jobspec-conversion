#!/bin/bash
#FLUX: --job-name=red-fudge-4444
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python model_normal.py
