#!/bin/bash
#FLUX --job-name=scruptious-knife-3742
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python retrieval.py
