#!/bin/bash
#FLUX: --job-name=primal-train
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load anaconda
module load boost/1.64.0
module load cuda/9.0.176 cudnn/cuda-9.0_7.4
source activate 571project
python -u primal_train.py
