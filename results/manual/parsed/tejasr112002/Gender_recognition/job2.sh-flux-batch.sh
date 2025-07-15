#!/bin/bash
#FLUX: --job-name=dlnn-job
#FLUX: --queue=SCSEGPU_UG
#FLUX: -t=14400
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/'

module load anaconda
source activate Deeplearning
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
python main.py GenderR4 1
