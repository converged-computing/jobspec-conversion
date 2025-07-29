#!/bin/bash
#FLUX --job-name=chocolate-bits-0435
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python model_normal.py
