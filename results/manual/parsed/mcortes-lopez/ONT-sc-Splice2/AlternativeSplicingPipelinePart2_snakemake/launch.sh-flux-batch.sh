#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=10
#FLUX: --queue=pe2
#FLUX: --priority=16

module load snakemake
snakemake --snakefile Snakefile \
  --configfile config.yaml \
  -j 6 \
  --stats stats.txt \
  --profile ../AlternativeSplicingPipelinePart1_snakemake/profiles/profile_snakemake/ \
  --cluster "sbatch --error=logs/test_%j_err.log --output=logs/test_%j_out.log --mem=80G --cpus-per-task=10"
