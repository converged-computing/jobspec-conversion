#!/bin/bash
#FLUX: --job-name=DINO_COCO
#FLUX: -c=4
#FLUX: --queue=bme_gpu
#FLUX: -t=432000
#FLUX: --urgency=16

set -x
CONFIG=$1
PY_ARGS=${@:2}
source activate det
nvidia-smi
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python -u tools/train.py ${CONFIG} --launcher="slurm" ${PY_ARGS}
