#!/bin/bash
#FLUX: --job-name=swampy-kerfuffle-1849
#FLUX: -c=5
#FLUX: --queue=small
#FLUX: -t=122400
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
