#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=test.log
#SBATCH --error=test.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=40G

module load snakemake
snakemake --snakefile Snakefile \
  --configfile config.yaml \
  -j 6 \
  --stats stats.txt \
  --profile ../AlternativeSplicingPipelinePart1_snakemake/profiles/profile_snakemake/ \
  --cluster "sbatch --error=logs/test_%j_err.log --output=logs/test_%j_out.log --mem=80G --cpus-per-task=10"
