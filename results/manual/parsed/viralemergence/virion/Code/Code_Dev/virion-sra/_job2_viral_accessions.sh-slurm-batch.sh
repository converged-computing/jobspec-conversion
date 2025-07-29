#!/bin/bash
#SBATCH --job-name=virion-2-viral-accessions
#SBATCH --account=def-tpoisot
#SBATCH --output=%x-%A-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=2300M
#SBATCH --time=01:00:00
#SBATCH --array=1-28

module load StdEnv/2020 julia/1.5.2
julia --project -t 38 02_parallel_viral_kmers.jl
