#!/bin/bash
#FLUX: --job-name=pico
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel python/3.6.8
python -u ./src/run_pico_experiments.py
