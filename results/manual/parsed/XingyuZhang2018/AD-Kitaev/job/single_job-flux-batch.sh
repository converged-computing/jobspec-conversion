#!/bin/bash
#FLUX: --job-name=confused-plant-6132
#FLUX: --queue=a100
#FLUX: -t=35996400
#FLUX: --urgency=16

module load julia-1.7.1
project_dir=~/research/AD_Kitaev
julia --project=${project_dir} ${project_dir}/job/K_J_Γ_Γ′.jl --K -1.0 --J -0.1 --Γ 0.3 --Γ′ -0.02 --field 0.01 --Ni 1 --Nj 2 --D 5 --chi 100 --folder ~/../../data/xyzhang/AD_Kitaev/ --type _zigzag
