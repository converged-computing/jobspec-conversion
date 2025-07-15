#!/bin/bash
#FLUX: --job-name=cowy-sundae-1425
#FLUX: --priority=16

module purge
module load python/3.10.12
python3 accretion.py
