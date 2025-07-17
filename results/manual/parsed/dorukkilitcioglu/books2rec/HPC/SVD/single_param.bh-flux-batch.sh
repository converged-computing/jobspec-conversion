#!/bin/bash
#FLUX: --job-name=muffled-avocado-8624
#FLUX: -c=5
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
python3 single_param.py
