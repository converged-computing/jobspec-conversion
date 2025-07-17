#!/bin/bash
#FLUX: --job-name=fuzzy-despacito-8202
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

source activate YOUR_CONDA_ENV
python main.py --user YOUR_USERNAME --yaml_config /PATH_TO_EXPERIMENT_CONFIGS/experiment_$SLURM_ARRAY_TASK_ID.yaml  # runs experiment_0.yaml --> experiment_2.yaml
