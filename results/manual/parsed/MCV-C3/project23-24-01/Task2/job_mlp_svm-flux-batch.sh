#!/bin/bash
#FLUX --job-name=hairy-car-6738
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python mlp_svm.py
