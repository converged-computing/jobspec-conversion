#!/bin/bash
#FLUX: --job-name=lovable-carrot-4514
#FLUX: -t=37380
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='/home/domenic/projects/def-hsajjad/domenic'
export HF_DATASETS_OFFLINE='1 '
export TRANSFORMERS_OFFLINE='1'

export TRANSFORMERS_CACHE=/home/domenic/projects/def-hsajjad/domenic
export HF_DATASETS_OFFLINE=1 
export TRANSFORMERS_OFFLINE=1
module load python/3.10.2 cuda nccl
module load gcc/9.3.0 arrow
sh run.sh
