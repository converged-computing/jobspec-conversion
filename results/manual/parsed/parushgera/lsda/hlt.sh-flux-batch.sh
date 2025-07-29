#!/bin/bash
#FLUX --job-name=hanky-lemon-9449
#FLUX --queue=CiBeR
#FLUX --urgency=16

source activate nlp
python hlt.py
