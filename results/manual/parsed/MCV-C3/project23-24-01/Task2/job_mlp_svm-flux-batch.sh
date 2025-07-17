#!/bin/bash
#FLUX: --job-name=stinky-muffin-5988
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python mlp_svm.py
