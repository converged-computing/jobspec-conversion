#!/bin/bash
#FLUX: --job-name=purple-salad-3799
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

export SLURM_EXPORT_ENV='ALL'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib'

export SLURM_EXPORT_ENV=ALL
source activate pytorch_bede
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib
nvidia-smi
python test_if_gpu_available_pytorch.py
