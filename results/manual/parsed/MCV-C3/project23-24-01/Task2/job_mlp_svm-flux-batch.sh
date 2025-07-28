#!/bin/bash
#FLUX: --job-name=placid-milkshake-7025
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python mlp_svm.py
