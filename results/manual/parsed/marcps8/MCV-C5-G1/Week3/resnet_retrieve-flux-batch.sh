#!/bin/bash
#FLUX: --job-name=stanky-nunchucks-8404
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python resnet_retrieval.py 
