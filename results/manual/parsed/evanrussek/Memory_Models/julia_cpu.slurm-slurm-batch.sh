#!/bin/bash
#SBATCH --job-name=tannou_new800
#SBATCH --output=slurm-%A.%a.out
#SBATCH --error=slurm-%A.%a.err
#SBATCH --mail-user=erussek@princeton.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=04:00:00
#SBATCH --array=1-300

module purge
module load julia/1.9.1
julia --project=. tanoue_param_search.jl
