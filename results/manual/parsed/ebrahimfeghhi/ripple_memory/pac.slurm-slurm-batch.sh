#!/bin/bash
#FLUX: --job-name=purple-leg-2276
#FLUX: --urgency=16

echo "Running task number $SLURM_ARRAY_TASK_ID"
python -u /home1/efeghhi/ripple_memory/analysis_code/pac_analyses/run_comod.py $SLURM_ARRAY_TASK_ID
