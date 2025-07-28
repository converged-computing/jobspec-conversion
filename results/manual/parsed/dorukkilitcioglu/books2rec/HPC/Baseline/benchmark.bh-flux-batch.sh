#!/bin/bash
#FLUX: --job-name=pusheena-milkshake-9385
#FLUX: -c=5
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
python3 benchmark.py
