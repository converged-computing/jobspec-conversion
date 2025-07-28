#!/bin/bash
#FLUX: --job-name=chunky-fudge-9285
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python retrieval.py
