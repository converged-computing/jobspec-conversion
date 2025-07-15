#!/bin/bash
#FLUX: --job-name=ornery-muffin-4764
#FLUX: --queue=soc-gpu-np
#FLUX: -t=28800
#FLUX: --urgency=16

source ~/miniconda3/etc/profile.d/conda.sh
conda activate TrainingPLM
pip install jsonlines
python create_json.py
