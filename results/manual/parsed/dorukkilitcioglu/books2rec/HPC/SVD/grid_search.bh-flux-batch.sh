#!/bin/bash
#FLUX: --job-name=fugly-avocado-2692
#FLUX: -c=5
#FLUX: -t=43200
#FLUX: --priority=16

module purge
python3 grid_search.py
