#!/bin/bash
#FLUX: --job-name=FAC
#FLUX: -c=80
#FLUX: --queue=dev
#FLUX: -t=259200
#FLUX: --priority=16

export PYTHONPATH='$PWD:$PYTHONPATH'

EXPERIMENT_PATH="./checkpoints/testlog"
mkdir -p $EXPERIMENT_PATH
export PYTHONPATH=$PWD:$PYTHONPATH
srun --output=${EXPERIMENT_PATH}/%j.out --error=${EXPERIMENT_PATH}/%j.err --label python scripts/singlenode-wrapper.py main.py $1
