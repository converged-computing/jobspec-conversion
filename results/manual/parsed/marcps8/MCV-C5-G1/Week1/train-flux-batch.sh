#!/bin/bash
#FLUX --job-name=hanky-knife-4099
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python model_normal.py
