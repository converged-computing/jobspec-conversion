#!/bin/bash
#FLUX: --job-name=blank-car-7197
#FLUX: --priority=16

source ~/.zshrc
conda activate nf-core-atacseq-1.2.1
prefetch -v SRR3689759
prefetch -v SRR3689760
prefetch -v SRR3689933	
prefetch -v SRR3689934	
fastq-dump --split-files --gzip /hpcwork/izkf/ncbi/sra/SRR3689759.sra
fastq-dump --split-files --gzip /hpcwork/izkf/ncbi/sra/SRR3689760.sra
fastq-dump --split-files --gzip /hpcwork/izkf/ncbi/sra/SRR3689933.sra
fastq-dump --split-files --gzip /hpcwork/izkf/ncbi/sra/SRR3689934.sra
/home/rs619065/miniconda3/bin/nextflow run nf-core/atacseq --input design.csv --genome hg38 --narrow_peak 
