#!/bin/bash
#FLUX: --job-name=faux-destiny-5147
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

export PYTHONUNBUFFERED='TRUE'

module load cuda/11.3.1
module load cudnn/8.2.0
nvidia-smi
export PYTHONUNBUFFERED=TRUE
python --version
python src/ecmointerp/modeling/transformerSingle.py
