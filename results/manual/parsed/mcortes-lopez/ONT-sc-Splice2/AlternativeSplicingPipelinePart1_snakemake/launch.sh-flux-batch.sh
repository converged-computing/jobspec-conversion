#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=5
#FLUX: --queue=pe2
#FLUX: --priority=16

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
