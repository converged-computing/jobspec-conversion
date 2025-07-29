#!/bin/bash
#FLUX --job-name=pusheena-knife-4270
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python resnet_retrieval.py 
