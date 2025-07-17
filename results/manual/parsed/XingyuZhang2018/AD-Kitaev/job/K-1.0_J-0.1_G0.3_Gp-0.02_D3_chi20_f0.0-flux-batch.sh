#!/bin/bash
#FLUX: --job-name=anxious-itch-6358
#FLUX: --queue=titanv
#FLUX: -t=35996400
#FLUX: --urgency=16

module load julia-1.7.1
project_dir=~/research/AD_Kitaev
julia --project=${project_dir} ${project_dir}/job/K_J_Γ_Γ′.jl --K -1.0 --J -0.1 --Γ 0.3 --Γ′ -0.02 --field 0.0 --D 3 --chi 20 --folder ~/../../data/xyzhang/AD_Kitaev/K_J_Γ_Γ′_1x2/ --type _random
