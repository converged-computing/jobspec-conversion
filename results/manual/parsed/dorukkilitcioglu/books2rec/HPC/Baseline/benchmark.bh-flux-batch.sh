#!/bin/bash
#FLUX: --job-name=boopy-truffle-9052
#FLUX: -c=5
#FLUX: -t=172800
#FLUX: --priority=16

module purge
python3 benchmark.py
