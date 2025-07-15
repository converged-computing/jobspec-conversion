#!/bin/bash
#FLUX: --job-name=wobbly-bike-4703
#FLUX: --priority=16

module purge
module load anaconda/py3
source activate xluo_civ
python utdf2gmns.py
