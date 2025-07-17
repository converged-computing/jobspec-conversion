#!/bin/bash
#FLUX: --job-name=FASTQC_snakemake
#FLUX: -t=345600
#FLUX: --urgency=16

export PERL5LIB='/packages/6x/vcftools/0.1.12b/lib/perl5/site_perl'

newgrp combinedlab
source activate nasonia_environment
export PERL5LIB=/packages/6x/vcftools/0.1.12b/lib/perl5/site_perl
snakemake --snakefile fastqc_trimmomatic.snakefile -j 20 --rerun-incomplete --cluster "sbatch -n 1 --nodes 1 -c 8 -t 96:00:00"
