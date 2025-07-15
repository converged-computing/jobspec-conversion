#!/bin/bash
#FLUX: --job-name=tart-hope-4253
#FLUX: --urgency=16

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
