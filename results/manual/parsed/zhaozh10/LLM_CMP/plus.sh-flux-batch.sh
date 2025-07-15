#!/bin/bash
#FLUX: --job-name=LLM_CMP_${TIME_SUFFIX}
#FLUX: --urgency=16

nvidia-smi
set -x
TGT_dir=$1
TIME_SUFFIX=$(date +%Y%m%d%H%M%S)
source activate win
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python chatcad_plus_eval.py --tgt_dir ${TGT_dir}
