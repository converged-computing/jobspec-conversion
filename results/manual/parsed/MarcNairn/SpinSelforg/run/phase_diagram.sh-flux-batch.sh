#!/bin/bash
#FLUX: --job-name=short_time_phase_diagram
#FLUX: --priority=16

srun julia run/phase_diagram.jl $SLURM_ARRAY_TASK_ID $1
