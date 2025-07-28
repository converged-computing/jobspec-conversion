#!/bin/bash
#FLUX: --job-name=expensive-bits-4901
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python custom_cnn.py
