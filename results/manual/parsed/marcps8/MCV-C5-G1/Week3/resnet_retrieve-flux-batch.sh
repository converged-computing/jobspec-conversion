#!/bin/bash
#FLUX: --job-name=quirky-lamp-6248
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python resnet_retrieval.py 
