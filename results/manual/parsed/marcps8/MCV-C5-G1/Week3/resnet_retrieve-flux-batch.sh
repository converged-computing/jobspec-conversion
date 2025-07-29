#!/bin/bash
#FLUX --job-name=lovely-ricecake-2441
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python resnet_retrieval.py 
