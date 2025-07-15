#!/bin/bash
#FLUX: --job-name=train
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/'

conda init bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate continuum-rl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
python ddpg.py
