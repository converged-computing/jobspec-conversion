#!/bin/bash
#FLUX: --job-name=red-squidward-3816
#FLUX: --urgency=16

module purge
module load anaconda/py3
source activate xluo_civ
python utdf2gmns.py
