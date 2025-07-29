#!/bin/bash
#SBATCH --job-name=bistable
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30G
#SBATCH --time=02:00:00

julia  -e 'using Pkg; Pkg.activate("projects/bistable")' \
       -e 'include("projects/bistable/src/run_count_lengths.jl")' \
       -O3 --banner=no $@
