#!/bin/bash
#FLUX: --job-name=TNG100_kin_train
#FLUX: -c=10
#FLUX: -t=14400
#FLUX: --priority=16

module purge
module load tensorflow-gpu
set -x
srun python main.py
