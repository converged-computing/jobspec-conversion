#!/bin/bash
#FLUX: --job-name=wsf-%A_%a
#FLUX: -t=180
#FLUX: --urgency=16

pwd; hostname; date
module load anaconda
source activate /home/nikolami/.conda/envs/ox112
python -u /p/projects/eubucco/git-eubucco/database/preprocessing/3-wsf/creating-wsf-evo-matching.py
