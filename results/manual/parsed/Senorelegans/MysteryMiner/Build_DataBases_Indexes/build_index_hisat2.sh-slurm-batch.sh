#!/bin/bash
#FLUX: --job-name=hisat2index
#FLUX: -n=16
#FLUX: --queue=short
#FLUX: -t=14700
#FLUX: --urgency=16

module load hisat2/2.1.0
IN=/scratch/Users/mame5141/2019/RNAseq-Biome-Nextflow/ensembl
FA=Homo_sapiens.GRCh38.dna.primary_assembly.fa
mkdir -p ${IN}/hisat2_index
hisat2-build -p 16 ${IN}/${FA} ${IN}/hisat2_index/genome
