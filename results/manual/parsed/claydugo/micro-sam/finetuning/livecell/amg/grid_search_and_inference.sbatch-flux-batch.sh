#!/bin/bash
#FLUX: --job-name=stinky-egg-9875
#FLUX: --urgency=16

source activate sam
python grid_search_and_inference.py $@
