#!/bin/bash
#FLUX: --job-name=DVRPSR20
#FLUX: -N=2
#FLUX: -n=4
#FLUX: -t=86400
#FLUX: --urgency=16

export CONDA_ROOT='$HOME/miniconda3'
export PATH='$CONDA_ROOT/bin:$PATH'

module load GCCcore/.12.2.0
module load Python/3.10.8
module load cuDNN/8.6.0.163-CUDA-11.8.0
export CONDA_ROOT=$HOME/miniconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"
conda activate base
python run_model.py
