#!/bin/bash
#SBATCH --job-name=GATK_HaplotypeCaller_ASE
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00

export PERL5LIB='/packages/6x/vcftools/0.1.12b/lib/perl5/site_perl'

newgrp combinedlab
source activate nasonia_environment
module load java/8u92
export PERL5LIB=/packages/6x/vcftools/0.1.12b/lib/perl5/site_perl
snakemake --snakefile gatk_haplotypecaller_asereadcounter.snakefile -j 20 --rerun-incomplete --cluster "sbatch -n 1 --nodes 1 -c 8 -t 96:00:00"
