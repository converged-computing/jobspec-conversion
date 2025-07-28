#!/bin/bash
#FLUX: --job-name=evasive-pancake-7650
#FLUX: --queue=CiBeR
#FLUX: --urgency=16

source activate nlp
python hlt.py
