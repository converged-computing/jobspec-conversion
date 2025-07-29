#!/bin/bash
#SBATCH --job-name=netCTL
#SBATCH --mail-user=eknodel@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1024
#SBATCH --time=4-00:00:00

newgrp combinedlab
source activate var_call_env
PERL5LIB=/packages/6x/vcftools/0.1.12b/lib/per15/site_perl
snakemake --snakefile netMHCpan-snakemake.py -j 15 --keep-target-files --rerun-incomplete --cluster "sbatch -q tempboost -n 1 -c 8 -t 96:00:00"
