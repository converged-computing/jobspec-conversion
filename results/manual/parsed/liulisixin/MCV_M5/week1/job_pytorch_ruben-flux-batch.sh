#!/bin/bash
#FLUX --job-name=astute-platanos-8042
#FLUX -n=4
#FLUX --queue=mhigh,mlow
#FLUX --urgency=16

python model.py
