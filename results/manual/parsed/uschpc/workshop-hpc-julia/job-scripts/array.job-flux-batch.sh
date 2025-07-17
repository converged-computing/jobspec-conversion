#!/bin/bash
#FLUX: --job-name=expressive-muffin-1946
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load julia/1.10.2
julia --threads $SLURM_CPUS_PER_TASK array.jl
