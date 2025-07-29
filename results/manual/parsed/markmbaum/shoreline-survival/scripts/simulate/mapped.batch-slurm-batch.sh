#!/bin/bash
#SBATCH --output=mapped.out
#SBATCH --error=mapped.err
#SBATCH --mail-user=markbaum@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=3000
#SBATCH --time=12-00:00:00

module purge
module load Julia/1.7.1-linux-x86_64
julia --threads 48 mapped.jl
