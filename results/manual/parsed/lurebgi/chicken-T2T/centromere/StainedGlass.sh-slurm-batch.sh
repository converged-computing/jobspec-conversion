#!/bin/bash
#FLUX: --job-name=stain
#FLUX: -c=8
#FLUX: --queue=basic
#FLUX: --urgency=16

chr=$1
module unload python2
module load python2/2.7.14
samtools faidx v22.fa $chr:0-900000 > $chr/$chr.fa
samtools faidx $chr/$chr.fa
snakemake --cores 8 --config sample=$chr fasta=$chr/$chr.fa #window=900
snakemake --config sample=$chr fasta=$chr/$chr.fa --cores 8 make_figures
