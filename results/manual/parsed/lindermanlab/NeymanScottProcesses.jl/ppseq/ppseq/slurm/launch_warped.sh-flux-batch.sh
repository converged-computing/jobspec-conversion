#!/bin/bash
#FLUX: --job-name=warped
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Working Directory = $(pwd)"
module load julia
srun julia launch_warped_slurm.jl
