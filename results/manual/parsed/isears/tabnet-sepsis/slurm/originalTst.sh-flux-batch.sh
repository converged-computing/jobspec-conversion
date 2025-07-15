#!/bin/bash
#FLUX: --job-name=goodbye-poo-2385
#FLUX: -c=16
#FLUX: -t=1800
#FLUX: --urgency=16

export PYTHONUNBUFFERED='TRUE'

module load cuda/11.3.1
module load cudnn/8.2.0
nvidia-smi
export PYTHONUNBUFFERED=TRUE
python --version
python src/tabsep/modeling/originalTst.py
