#!/bin/bash
#FLUX: --job-name=moolicious-lemur-9608
#FLUX: --priority=16

set -ex
NPROC=$(nproc)
if [[ $NPROC -ge 10 ]]; then
    WORKERS=$(($NPROC / 2))
else
    WORKERS=$NPROC
fi
nvidia-smi
env | sort
python main.py jester RGB \
    --workers $WORKERS \
    $ARGS \
    "$@"
