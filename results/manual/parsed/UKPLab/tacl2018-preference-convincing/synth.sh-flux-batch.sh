#!/bin/bash
#FLUX: --job-name=grated-poo-5006
#FLUX: --exclusive
#FLUX: --urgency=16

module load intel python/3.6.8
OMP_NUM_THREADS=20 python3 -u python/analysis/simulations/synth_tests.py 0
OMP_NUM_THREADS=20 python3 -u python/analysis/simulations/synth_tests.py 1
