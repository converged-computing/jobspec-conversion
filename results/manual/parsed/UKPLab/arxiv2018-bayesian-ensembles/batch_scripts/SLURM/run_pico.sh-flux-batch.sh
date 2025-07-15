#!/bin/bash
#FLUX: --job-name=stinky-lamp-6301
#FLUX: --exclusive
#FLUX: --urgency=16

module load intel python/3.6.8
python -u ./src/run_pico_experiments.py
