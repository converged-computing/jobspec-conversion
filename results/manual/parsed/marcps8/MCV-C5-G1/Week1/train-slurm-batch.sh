#!/bin/bash
#FLUX: --job-name=bricky-puppy-8088
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python model_normal.py
