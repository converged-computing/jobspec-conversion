#!/bin/bash
#FLUX: --job-name=memory_encoding
#FLUX: -t=259200
#FLUX: --urgency=16

export WANDB_EXECUTABLE='$CONDA_PREFIX/bin/python'
export WANDB_MODE='offline'
export HF_DATASETS_OFFLINE='1'

set -e
set -u
nvidia-smi
source /apps/miniconda3/latest/etc/profile.d/conda.sh
conda activate hebby
export WANDB_EXECUTABLE=$CONDA_PREFIX/bin/python
export WANDB_MODE=offline
export HF_DATASETS_OFFLINE=1
bash run_training.sh
