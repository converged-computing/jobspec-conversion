#!/bin/bash
#FLUX: --job-name=astute-noodle-5510
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load StdEnv/2020 gcc/9.3.0 arrow/11.0.0 python/3.10
source ~/projects/def-azouaq/mrouss/onlp-env/bin/activate
pip list
cd ~/projects/def-azouaq/mrouss/o-nlp/
wandb offline
nvidia-smi
python main.py configs/t5_sft.toml
