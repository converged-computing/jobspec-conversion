#!/bin/bash
#FLUX: --job-name=DreamerTraining_Prelim
#FLUX: -t=3600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load miniconda3/23.3.1-py310  cuda/12.3.0
source activate pytorch
python3 valid_dynamics.py
python3 test_dynamics.py
