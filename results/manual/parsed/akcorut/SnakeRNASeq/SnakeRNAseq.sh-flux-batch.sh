#!/bin/bash
#FLUX: --job-name=peanut_rna_seq
#FLUX: -c=20
#FLUX: --queue=highmem_p
#FLUX: -t=86400
#FLUX: --priority=16

export LC_ALL='en_SG.utf8'
export LANG='en_SG.utf8'

source /apps/lmod/lmod/init/zsh
cd /scratch/ac32082/02.PeanutRNASeq/peanut_rnaseq_scripts/snakemake_workflows/peanut_rna_seq_analysis
module load Anaconda3/5.0.1
source activate snake_conda
export LC_ALL=en_SG.utf8
export LANG=en_SG.utf8
snakemake -n --use-conda --verbose --cores 20 --latency-wait 6000 --rerun-incomplete -s Snakefile
