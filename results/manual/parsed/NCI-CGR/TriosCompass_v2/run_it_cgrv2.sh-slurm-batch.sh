#!/bin/bash
#SBATCH --output=${PWD}/snakemake.%j.out
#SBATCH --error=${PWD}/snakemake.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=8-08:00:00

export TMPDIR='TMP'

mkdir -p TMP
export TMPDIR=TMP
module load singularity 
snakemake --skip-script-cleanup -k  --keep-incomplete --rerun-incomplete --profile workflow/profiles/biowulf --verbose -p --use-conda --jobs 400 --use-singularity --use-envmodules --latency-wait 600 -T 0 -s Snakefile_CGRv2
