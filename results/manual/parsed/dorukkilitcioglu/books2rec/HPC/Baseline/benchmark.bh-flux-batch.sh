#!/bin/bash
#FLUX: --job-name=fat-avocado-4345
#FLUX: -c=5
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
python3 benchmark.py
