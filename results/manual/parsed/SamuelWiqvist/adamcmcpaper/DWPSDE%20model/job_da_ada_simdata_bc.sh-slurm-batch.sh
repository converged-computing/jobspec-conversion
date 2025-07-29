#!/bin/bash
#SBATCH --job-name=da_ada_simdata_bc
#SBATCH --account=lu2018-2-22
#SBATCH --output=lunarc_output/mcmc
#SBATCH --error=lunarc_output/mcmc
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --time=4-04:00:00
#SBATCH --partition=lu

ml load icc/2017.1.132-GCC-6.3.0-2.27
ml load impi/2017.1.132
ml load julia/0.5.2
julia run_da_ada_same_training_data.jl simdata biasedcoin
