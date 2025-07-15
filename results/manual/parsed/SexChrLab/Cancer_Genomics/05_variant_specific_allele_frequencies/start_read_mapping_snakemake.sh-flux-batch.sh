#!/bin/bash
#FLUX: --job-name=nerdy-parrot-3197
#FLUX: --urgency=16

source activate cancergenomics
PERL5LIB=/packages/6x/vcftools/0.1.12b/lib/per15/site_perl
snakemake --snakefile hisat2_read_mapping.snakefile -j 15 --keep-target-files --rerun-incomplete --cluster "sbatch -N 1 -n 1  -t 2-00:00:00 --mem=100G -p general -q public"
