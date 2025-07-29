#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=416-15:00:00
#SBATCH --partition=a100

module load julia-1.7.1
project_dir=~/research/AD_Kitaev
julia --project=${project_dir} ${project_dir}/job/K_J_Γ_Γ′.jl --K 1.0 --J 0.0 --Γ 0.0 --Γ′ 0.0 --field 0.0 --Ni 1 --Nj 1 --D 4 --chi 80 --folder ~/../../data/xyzhang/AD_Kitaev/ --type _random
