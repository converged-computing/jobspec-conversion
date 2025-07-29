#!/bin/bash
#FLUX: --job-name=annotate
#FLUX: -c=10
#FLUX: -t=14400
#FLUX: --urgency=16

export PYTHONPATH='.'

module purge
module load cpuarch/amd
module load python/3.8.2
conda activate /linkhome/rech/genzuo01/uez75lm/.conda/envs/childes-grammaticality
cd $WORK/childes-contingency
export PYTHONPATH=.
set -x
TRANSFORMERS_OFFLINE=1
model=lightning_logs/version_399240
model_type=child
python -u nn/annotate_contingency_nn.py --model $model --model-type $model_type
