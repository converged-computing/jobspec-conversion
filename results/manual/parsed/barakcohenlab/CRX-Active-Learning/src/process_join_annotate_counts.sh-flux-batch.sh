#!/bin/bash
#FLUX: --job-name=persnickety-cinnamonbun-4523
#FLUX: --urgency=16

eval $(spack load --sh miniconda3)
source activate active-learning
python3 src/process_and_join_counts.py
python3 src/annotate_data.py
