#!/bin/bash
#FLUX: --job-name=anxious-parrot-9019
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

export PYTHONUNBUFFERED='TRUE'

module load cuda/11.3.1
module load cudnn/8.2.0
nvidia-smi
export PYTHONUNBUFFERED=TRUE
python3 src/tabsep/modeling/timeseriesCV.py TST
