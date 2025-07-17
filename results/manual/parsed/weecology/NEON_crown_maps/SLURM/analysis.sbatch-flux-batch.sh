#!/bin/bash
#FLUX: --job-name=DeepForest
#FLUX: -t=259200
#FLUX: --urgency=16

source activate crowns
cd /home/b.weinstein/NEON_crown_maps/analysis/
python dask_analysis.py
