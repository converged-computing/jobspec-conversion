#!/bin/bash
#FLUX: --job-name=confused-rabbit-9321
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python mlp_svm.py
