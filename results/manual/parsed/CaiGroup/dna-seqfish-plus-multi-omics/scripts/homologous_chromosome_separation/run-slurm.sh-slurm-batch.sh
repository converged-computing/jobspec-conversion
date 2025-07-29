#!/bin/bash
#SBATCH --job-name=snakemaster
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=1-00:00:00

module load julia/1.6.2
snakemake --cores=1 --cluster 'sbatch -t 2000 --mem=5g -c 1' -j 100 
