#!/bin/bash
#FLUX: --job-name="nyt_single"
#FLUX: --queue=batch
#FLUX: --priority=16

module load julia/1.5.0
cd /users/yh31/scratch/projects/gigaword_64k/
julia --project=@. /users/yh31/scratch/projects/gigaword_64k/src/nyt_mapper_single.jl
