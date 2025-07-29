#!/bin/bash
#FLUX: --job-name=finetune
#FLUX: -c=10
#FLUX: -t=18000
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
model=microsoft/deberta-v3-large          #microsoft/deberta-v3-base    # babylm/roberta-base-strict    #gpt2   #       roberta-large   #cointegrated/roberta-large-cola-krishna2020    #phueb/BabyBERTa-3      #bert-base-uncased
context_length=0
model_type=parent
python -u nn/fine_tuning_nn.py --accelerator gpu --model $model --context-length $context_length --model-type $model_type
