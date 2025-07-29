#!/bin/bash
#SBATCH --job-name=fully
#SBATCH --output=outputs/fully_%A_%a.output
#SBATCH --mail-user=nick@nickeubank.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=2-00:00:00
#SBATCH --array=1-250

export CHUNK_SIZE='4'

export CHUNK_SIZE=4
julia fully_arrayed_individual_sim.jl
