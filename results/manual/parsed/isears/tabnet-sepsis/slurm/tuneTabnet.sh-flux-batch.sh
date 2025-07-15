#!/bin/bash
#FLUX: --job-name=dirty-gato-2377
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONUNBUFFERED='TRUE'

module load cuda/11.3.1
module load cudnn/8.2.0
nvidia-smi
export PYTHONUNBUFFERED=TRUE
python --version
python src/tabsep/modeling/tuneTabnet.py $1
