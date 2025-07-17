#!/bin/bash
#FLUX: --job-name=static_pump_Nmc
#FLUX: --urgency=16

srun julia run/JUSTUS_draft_run/run_parallel_justus_static.jl $SLURM_ARRAY_TASK_ID $1 $2 $3 $4
