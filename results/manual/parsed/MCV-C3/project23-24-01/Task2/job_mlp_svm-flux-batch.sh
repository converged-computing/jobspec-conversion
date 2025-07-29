#!/bin/bash
#FLUX --job-name=goodbye-lizard-8417
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python mlp_svm.py
