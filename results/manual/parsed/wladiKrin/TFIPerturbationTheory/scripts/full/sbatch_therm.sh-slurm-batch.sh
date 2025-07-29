#!/bin/bash
#FLUX: --job-name=EDTherm
#FLUX: -c=48
#FLUX: --urgency=16

srun julia Hfull_Bound_therm.jl ${SLURM_ARRAY_TASK_ID}
