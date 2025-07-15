#!/bin/bash
#FLUX: --job-name=decoding
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --priority=16

export PYTHONPATH='$PWD":$PYTHONPATH'

echo slurm_task $SLURM_ARRAY_TASK_ID
export PYTHONPATH="$PWD":$PYTHONPATH
echo
python 04_decode_single_session.py $SLURM_ARRAY_TASK_ID
