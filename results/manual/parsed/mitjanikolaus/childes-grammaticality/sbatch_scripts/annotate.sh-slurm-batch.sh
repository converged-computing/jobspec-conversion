#!/bin/bash
#FLUX: --job-name=annotate
#FLUX: -c=10
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load cpuarch/amd
module load python
conda activate childes_grammaticality
set -x
TRANSFORMERS_OFFLINE=1
model=lightning_logs/version_408635
data_dir=data/manual_annotation/all/
python -u grammaticality_annotation/annotate_grammaticality_nn.py --model $model --data-dir $data_dir
