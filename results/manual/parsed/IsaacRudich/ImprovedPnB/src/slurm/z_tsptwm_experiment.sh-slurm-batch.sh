#!/bin/bash
#SBATCH --mail-user=isaac.rudich@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=186G
#SBATCH --time=01:30:00

module load julia
julia z_tsptwm_experiment.jl $setnum $instance
