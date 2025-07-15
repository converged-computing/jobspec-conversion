#!/bin/bash
#FLUX: --job-name=astute-carrot-5136
#FLUX: --urgency=16

module load python3/3.9-anaconda-2021.11
module list
set -x
srun -l -u python ./IOD-train-tabnet.py
