#!/bin/bash
#FLUX --job-name=misunderstood-truffle-3945
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python custom_cnn.py
