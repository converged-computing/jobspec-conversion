#!/bin/bash
#FLUX: --job-name=swampy-general-9181
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python model_normal.py
