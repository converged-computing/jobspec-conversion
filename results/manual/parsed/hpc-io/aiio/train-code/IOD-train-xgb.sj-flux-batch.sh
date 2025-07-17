#!/bin/bash
#FLUX: --job-name=xgb
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=72600
#FLUX: --urgency=16

module load cgpu
module load python3/3.9-anaconda-2021.11
module list
set -x
srun -l -u python ./IOD-train-xgb.py
