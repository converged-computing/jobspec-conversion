#!/bin/bash
#FLUX --job-name=stanky-despacito-4185
#FLUX -n=4
#FLUX --queue=mhigh,mlow
#FLUX --urgency=16

python model.py
