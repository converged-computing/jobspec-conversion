#!/bin/bash
#FLUX: --job-name=faux-underoos-6187
#FLUX: -t=7199
#FLUX: --urgency=16

module load tensorflow/1.14.0-py36-gpu
python3 scripts/benchmark_grid.py $@
