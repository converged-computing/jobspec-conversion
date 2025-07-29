#!/bin/bash
#FLUX --job-name=joyous-soup-3097
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python retrieval.py
