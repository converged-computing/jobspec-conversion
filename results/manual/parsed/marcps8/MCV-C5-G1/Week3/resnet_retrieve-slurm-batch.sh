#!/bin/bash
#FLUX: --job-name=dirty-pancake-3784
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python resnet_retrieval.py 
