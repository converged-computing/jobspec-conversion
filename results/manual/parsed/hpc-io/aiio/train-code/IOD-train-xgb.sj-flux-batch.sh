#!/bin/bash
#FLUX: --job-name=chocolate-frito-6728
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

module load cgpu
module load python3/3.9-anaconda-2021.11
module list
set -x
srun -l -u python ./IOD-train-xgb.py
