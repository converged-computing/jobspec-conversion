#!/bin/bash
#FLUX: --job-name=rainbow-onion-9649
#FLUX: -t=1800
#FLUX: --priority=16

module purge
module load StdEnv/2020 gcc/9.3.0 arrow/11.0.0 python/3.10
source ~/projects/def-azouaq/mrouss/onlp-env/bin/activate
pip list
cd ~/projects/def-azouaq/mrouss/o-nlp/
wandb offline
nvidia-smi
python main.py configs/bart_sft.toml
