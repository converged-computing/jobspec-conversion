#!/bin/bash
#FLUX: --job-name=dirty-plant-2014
#FLUX: --priority=16

source activate sam
python grid_search_and_inference.py $@
