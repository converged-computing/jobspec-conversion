#!/bin/bash
#FLUX: --job-name=quirky-dog-3016
#FLUX: -n=4
#FLUX: --queue=mhigh,mlow
#FLUX: --urgency=16

python model.py
