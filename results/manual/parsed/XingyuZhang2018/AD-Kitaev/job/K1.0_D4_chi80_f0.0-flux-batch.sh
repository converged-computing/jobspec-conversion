#!/bin/bash
#FLUX: --job-name=persnickety-lamp-8922
#FLUX: --queue=a100
#FLUX: -t=35996400
#FLUX: --urgency=16

module load julia-1.7.1
project_dir=~/research/AD_Kitaev
julia --project=${project_dir} ${project_dir}/job/K_J_Γ_Γ′.jl --K 1.0 --J 0.0 --Γ 0.0 --Γ′ 0.0 --field 0.0 --Ni 1 --Nj 1 --D 4 --chi 80 --folder ~/../../data/xyzhang/AD_Kitaev/ --type _random
