#!/bin/bash
#FLUX: --job-name=pre_lstm
#FLUX: -c=10
#FLUX: -t=36000
#FLUX: --urgency=16

export TRANSFORMERS_OFFLINE='1'
export TOKENIZERS_PARALLELISM='false'

module purge
module load cpuarch/amd
module load python
conda activate childes_grammaticality
set -x
export TRANSFORMERS_OFFLINE=1
export TOKENIZERS_PARALLELISM=false
python -u grammaticality_annotation/pretrain_lstm.py --learning-rate 1e-3
