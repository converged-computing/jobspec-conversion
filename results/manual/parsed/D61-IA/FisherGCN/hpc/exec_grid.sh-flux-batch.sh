#!/bin/bash
#FLUX: --job-name=fugly-kerfuffle-8859
#FLUX: -t=7199
#FLUX: --priority=16

module load tensorflow/1.14.0-py36-gpu
python3 scripts/benchmark_grid.py $@
