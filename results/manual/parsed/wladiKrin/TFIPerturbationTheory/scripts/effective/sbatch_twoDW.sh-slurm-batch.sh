#!/bin/bash
#FLUX: --job-name=2DW
#FLUX: -c=48
#FLUX: --urgency=16

srun julia -t 48 Heff_twoDWStates.jl ${SLURM_ARRAY_TASK_ID}
