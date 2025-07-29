#!/bin/bash
#FLUX --job-name=stanky-hope-0923
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python MOTS-train.py -p mlow
