#!/bin/bash
#FLUX --job-name=red-leg-4160
#FLUX -c=5
#FLUX -t=172800
#FLUX --urgency=16

module purge
python3 benchmark.py
