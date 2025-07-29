#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=test.log
#SBATCH --error=test.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=20G
#SBATCH --partition=pe2

module load java/1.9
module load samtools
module load bedtools
module load racon
source activate sicelore2.0
which python
snakemake -v
snakemake --snakefile Snakefile_multi \
  --configfile config.yml \
  --stats stats.txt \
  --profile ../AlternativeSplicingPipelinePart1_snakemake/profiles/profile_snakemake/ 
  #--cluster "sbatch --error=logs/test_%j_err.log --output=logs/test_%j_out.log --mem=100G --cpus-per-task=10"
