#!/bin/bash
#FLUX --job-name=tart-taco-3350
#FLUX --queue=CiBeR
#FLUX --urgency=16

source activate nlp
python hlt.py
