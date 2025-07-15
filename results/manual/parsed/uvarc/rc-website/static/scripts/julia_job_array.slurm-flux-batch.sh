#!/bin/bash
#FLUX: --job-name=runMultiple
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load julia/1.5.0
export SLURM_ARRAY_TASK_ID
julia jobArray.jl
