#!/bin/bash
#FLUX: --job-name=joyous-dog-8199
#FLUX: --urgency=16

module load python3/3.9-anaconda-2021.11
module list
set -x
srun -l -u python ./IOD-train-xgb-lightGBM.py
