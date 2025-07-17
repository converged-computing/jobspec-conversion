#!/bin/bash
#FLUX: --job-name=sushi_100
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel python/3.6.8
OMP_NUM_THREADS=8 python3 -u python/analysis/sushi_10_tests.py 0
OMP_NUM_THREADS=8 python3 -u python/analysis/sushi_10_tests.py 2
OMP_NUM_THREADS=8 python3 -u python/analysis/sushi_10_tests.py 4
