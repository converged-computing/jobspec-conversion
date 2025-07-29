#!/bin/bash
#SBATCH --job-name=PSPFullYear
#SBATCH --mail-user=yuting.mou@uclouvain.be
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=3900
#SBATCH --time=12:00:00

julia --depwarn=no PSPMIP.jl
