#!/bin/bash
#FLUX: --job-name=adorable-peanut-butter-2821
#FLUX: -n=4
#FLUX: --queue=mhigh,mlow
#FLUX: --urgency=16

python model.py
