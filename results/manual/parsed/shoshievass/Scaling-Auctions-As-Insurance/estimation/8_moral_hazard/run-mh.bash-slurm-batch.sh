#!/bin/bash
#SBATCH --job-name=hazard
#SBATCH --output=/zfs/projects/faculty/svass-bang/logs/mh-logs/%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=2-00:00:00
#SBATCH --array=1-430

export JLGUROBI='true'

module load julia/1.7.3 gurobi
export JLGUROBI=true
julia --threads=4 --project 8-hazard.jl
