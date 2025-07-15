#!/bin/bash
#FLUX: --job-name=CAE_train
#FLUX: -t=36000
#FLUX: --priority=16

module purge
module load cuda/8.0.44
module load python3/intel/3.6.3
source $HOME/pyenv/py3.6.3/bin/activate
python CAE_train.py
