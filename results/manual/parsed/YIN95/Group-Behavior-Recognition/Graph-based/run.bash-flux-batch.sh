#!/bin/bash
#FLUX: --job-name=salted-egg-6954
#FLUX: -c=8
#FLUX: --priority=16

printenv $SLURM_STEP_GPUS
nvidia-smi
. ~/miniconda3/etc/profile.d/conda.sh
conda activate tr
python main.py recognition -c config/st_gcn.twostream/congreg8-marker/train.yaml
