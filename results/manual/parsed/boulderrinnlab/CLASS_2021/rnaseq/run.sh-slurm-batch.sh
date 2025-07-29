#!/bin/bash
#FLUX: --job-name=HEPG2_rna_seq
#FLUX: --queue=long
#FLUX: -t=72000
#FLUX: --urgency=16

pwd; hostname; date
echo "Here we go You've requested $SLURM_CPUS_ON_NODE core."
module load singularity/3.1.1
nextflow run nf-core/rnaseq -r 1.4.2 \
-resume \
-profile singularity \
--reads 'fastq/*{_read1,_read2}.fastq.gz' \
--fasta /scratch/Shares/rinn/genomes/Homo_sapiens/Gencode/v32/GRCh38.p13.genome.fa \
--gtf /scratch/Shares/rinn/genomes/Homo_sapiens/Gencode/v32/gencode.v32.annotation.gtf \
--pseudo_aligner salmon \
--gencode \
--email john.rinn@colorado.edu \
-c nextflow.config
date
