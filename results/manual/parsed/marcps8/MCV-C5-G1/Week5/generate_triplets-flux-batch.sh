#!/bin/bash
#FLUX --job-name=boopy-leg-8107
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python triplets_generator.py
