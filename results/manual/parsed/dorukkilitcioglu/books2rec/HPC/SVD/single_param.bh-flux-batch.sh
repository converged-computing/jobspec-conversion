#!/bin/bash
#FLUX: --job-name=fugly-peanut-4219
#FLUX: -c=5
#FLUX: -t=43200
#FLUX: --priority=16

module purge
python3 single_param.py
