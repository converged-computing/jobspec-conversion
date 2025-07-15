#!/bin/bash
#FLUX: --job-name=sticky-leg-3047
#FLUX: --priority=16

export PYTHONUNBUFFERED='1'

module load cuda11.2/toolkit
cd ~/work/text-to-anime
. "/export/home/qiao002/miniconda3/etc/profile.d/conda.sh"
conda activate text-to-anime
export PYTHONUNBUFFERED=1
set -x
CUDA_VISIBLE_DEVICES=1 python train.py "$@"
