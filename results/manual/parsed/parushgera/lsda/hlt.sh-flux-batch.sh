#!/bin/bash
#FLUX: --job-name=boopy-motorcycle-0400
#FLUX: --queue=CiBeR
#FLUX: --urgency=16

source activate nlp
python hlt.py
