#!/bin/bash
#FLUX: --job-name=netCTL  # Job name
#FLUX: --priority=16

newgrp combinedlab
source activate var_call_env
PERL5LIB=/packages/6x/vcftools/0.1.12b/lib/per15/site_perl
snakemake --snakefile netMHCpan-snakemake.py -j 15 --keep-target-files --rerun-incomplete --cluster "sbatch -q tempboost -n 1 -c 8 -t 96:00:00"
