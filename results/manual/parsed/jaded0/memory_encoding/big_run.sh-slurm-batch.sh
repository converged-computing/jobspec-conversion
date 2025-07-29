#!/bin/bash
#SBATCH --job-name=memory_encoding
#SBATCH --mail-user=jaden.lorenc@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=16000M
#SBATCH --time=3-00:00:00

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
