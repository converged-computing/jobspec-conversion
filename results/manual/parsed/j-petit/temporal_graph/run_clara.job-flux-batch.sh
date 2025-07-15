#!/bin/bash
#FLUX: --job-name=milky-staircase-5585
#FLUX: -c=24
#FLUX: -t=72000
#FLUX: --urgency=16

if [ -z "$SLURM_ARRAY_TASK_ID" ]; then
    SLURM_ARRAY_TASK_ID=1
fi
. "$HOME/miniconda3/etc/profile.d/conda.sh"
conda activate temp_graph
python run.py
