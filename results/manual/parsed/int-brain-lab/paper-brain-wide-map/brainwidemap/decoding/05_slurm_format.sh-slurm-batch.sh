#!/bin/bash
#FLUX: --job-name=decoding
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

export PYTHONPATH='$PWD":$PYTHONPATH'

echo index $SLURM_ARRAY_TASK_ID
export PYTHONPATH="$PWD":$PYTHONPATH
echo
python  05_format_results.py $SLURM_ARRAY_TASK_ID
