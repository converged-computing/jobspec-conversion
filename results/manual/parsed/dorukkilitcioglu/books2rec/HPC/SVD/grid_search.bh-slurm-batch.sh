#!/bin/bash
#FLUX: --job-name=scruptious-train-8980
#FLUX: -c=5
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
python3 grid_search.py
