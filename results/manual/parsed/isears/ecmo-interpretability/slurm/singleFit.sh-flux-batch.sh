#!/bin/bash
#FLUX: --job-name=pusheena-hope-2103
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --priority=16

export PYTHONUNBUFFERED='TRUE'

module load cuda/11.3.1
module load cudnn/8.2.0
nvidia-smi
export PYTHONUNBUFFERED=TRUE
python --version
python src/ecmointerp/modeling/transformerSingle.py
