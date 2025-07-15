#!/bin/bash
#FLUX: --job-name=diffae_autoenc
#FLUX: -t=14400
#FLUX: --priority=16

export CONDA_ROOT='$HOME/anaconda3'
export PATH='$CONDA_ROOT/bin:$PATH'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

module load CUDA
export CONDA_ROOT=$HOME/anaconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"
conda activate diffautoenc
echo; export; echo; nvidia-smi; echo
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python test_manipulate.py
