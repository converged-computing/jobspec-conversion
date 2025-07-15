#!/bin/bash
#FLUX: --job-name=boopy-lizard-3393
#FLUX: -t=86400
#FLUX: --priority=16

source /users/afengler/.bashrc
conda deactivate
conda activate tf-gpu-py37
machine='ccv'
python gru_language_model.py --machine $machine  --idx $SLURM_ARRAY_TASK_ID
