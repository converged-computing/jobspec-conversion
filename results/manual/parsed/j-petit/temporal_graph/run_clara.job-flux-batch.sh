#!/bin/bash
#FLUX: --job-name=goodbye-dog-8316
#FLUX: -c=24
#FLUX: --queue=clara-job
#FLUX: -t=72000
#FLUX: --urgency=16

if [ -z "$SLURM_ARRAY_TASK_ID" ]; then
    SLURM_ARRAY_TASK_ID=1
fi
. "$HOME/miniconda3/etc/profile.d/conda.sh"
conda activate temp_graph
python run.py
