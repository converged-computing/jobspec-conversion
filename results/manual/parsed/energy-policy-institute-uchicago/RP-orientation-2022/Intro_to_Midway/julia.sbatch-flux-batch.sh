#!/bin/bash
#FLUX: --job-name=serial_jl
#FLUX: -t=300
#FLUX: --urgency=16

module load julia
julia hello_world.jl $SLURM_ARRAY_TASK_ID
