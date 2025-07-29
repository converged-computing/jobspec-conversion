#!/bin/bash
#FLUX --job-name=crusty-cinnamonbun-1757
#FLUX -c=5
#FLUX -t=43200
#FLUX --urgency=16

module purge
python3 grid_search.py
