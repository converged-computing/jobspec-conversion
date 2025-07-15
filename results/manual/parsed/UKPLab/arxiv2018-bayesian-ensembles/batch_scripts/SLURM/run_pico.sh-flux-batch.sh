#!/bin/bash
#FLUX: --job-name=loopy-lemur-4060
#FLUX: --exclusive
#FLUX: --priority=16

module load intel python/3.6.8
python -u ./src/run_pico_experiments.py
