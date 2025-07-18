#!/bin/bash
#FLUX: --job-name=parseC32
#FLUX: --queue=Brody
#FLUX: -t=345600
#FLUX: --urgency=16

module load julia/0.6.3
echo "Slurm Job ID: $SLURM_JOB_ID"
echo "Slurm Array Task ID: $SLURM_ARRAY_TASK_ID"
julia C32_parse_finished.jl 
