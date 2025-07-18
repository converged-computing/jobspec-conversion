#!/bin/bash
#FLUX: --job-name=ftc-atacseq
#FLUX: --queue=long
#FLUX: -t=180000
#FLUX: --urgency=16

pwd; hostname; date
echo "You've requested $SLURM_CPUS_ON_NODE core."
module load singularity/3.1.1
nextflow run nf-core/atacseq -r 1.2.0 \
-resume \
-profile singularity \
--input atacseq_design.csv \
--fasta ../../../genomes/Mus_musculus/Gencode/M25/GRCm38.p6.genome.fa \
--gtf ../../../genomes/Mus_musculus/Gencode/M25/gencode.vM25.annotation.gtf \
--blacklist mm10-blacklist.v2.bed \
--macs_gsize 1.87e9 \
--email michael.smallegan@colorado.edu \
-c nextflow.config
date
