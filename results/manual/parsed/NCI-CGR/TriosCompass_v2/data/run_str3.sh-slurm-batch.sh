#!/bin/bash
#SBATCH --output=${PWD}/snakemake.%j.out
#SBATCH --error=${PWD}/snakemake.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=8-08:00:00

snakemake --verbose --skip-script-cleanup -k  --rerun-incomplete --profile workflow/profiles/biowulf --verbose -p --use-conda --jobs 400 --use-singularity --use-envmodules --latency-wait 120 -T 0  -s Snakefile_STR3
