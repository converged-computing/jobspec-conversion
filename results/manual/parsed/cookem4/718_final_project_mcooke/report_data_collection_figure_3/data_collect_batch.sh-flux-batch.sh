#!/bin/bash
#FLUX: --job-name=mcooke_figure_3
#FLUX: -t=43200
#FLUX: --priority=16

module load NiaEnv/2019b
module load cmake
module load gcc
module load python/3
module load valgrind
python3 run_search_space.py
