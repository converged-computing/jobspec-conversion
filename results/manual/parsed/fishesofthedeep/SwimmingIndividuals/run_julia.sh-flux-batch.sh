#!/bin/bash
#FLUX: --job-name=SI_HC
#FLUX: -c=8
#FLUX: --queue=compute
#FLUX: -t=86400
#FLUX: --urgency=16

date
module load julia                  # Load the julia module
echo "Running julia script for SwimmingIndividuals.jl"
julia /vortexfs1/scratch/matthew.woodstock/SwimmingIndividuals/model.jl
date
