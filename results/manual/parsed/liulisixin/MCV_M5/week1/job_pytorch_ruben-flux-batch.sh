#!/bin/bash
#FLUX: --job-name=dinosaur-leader-6959
#FLUX: -n=4
#FLUX: --queue=mhigh,mlow
#FLUX: --urgency=16

python model.py
