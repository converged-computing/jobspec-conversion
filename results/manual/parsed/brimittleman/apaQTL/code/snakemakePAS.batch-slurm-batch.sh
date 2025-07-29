#!/bin/bash
#SBATCH --job-name=snakemakePAS
#SBATCH --output=snakePASlog.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00

bash submit-snakemakePAS.sh $*
