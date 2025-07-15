#!/bin/bash
#FLUX: --job-name=pusheena-toaster-2334
#FLUX: --exclusive
#FLUX: --priority=16

module load intel python/3.6.8
OMP_NUM_THREADS=8 python3 -u python/analysis/sushi_10_tests.py 0
OMP_NUM_THREADS=8 python3 -u python/analysis/sushi_10_tests.py 2
OMP_NUM_THREADS=8 python3 -u python/analysis/sushi_10_tests.py 4
