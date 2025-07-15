#!/bin/bash
#FLUX: --job-name=bloated-chair-8914
#FLUX: --exclusive
#FLUX: --priority=16

module load intel python/3.6.8
OMP_NUM_THREADS=20 python3 -u python/analysis/simulations/synth_tests.py 0
OMP_NUM_THREADS=20 python3 -u python/analysis/simulations/synth_tests.py 1
