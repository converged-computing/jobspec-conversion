#!/bin/bash
#FLUX: --job-name=peachy-hope-7253
#FLUX: --queue=CiBeR
#FLUX: --urgency=16

source activate nlp
python hlt.py
