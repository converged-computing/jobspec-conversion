#!/bin/bash
#FLUX: --job-name=cutnrun_chip_nfcore
#FLUX: --queue=long
#FLUX: -t=144000
#FLUX: --urgency=16

pwd; hostname; date
module load singularity/3.1.1
nextflow run nf-core/cutandrun -r 1.1 \
-profile singularity \
--input design.csv \
--fasta /scratch/Shares/rinn/genomes/Mus_musculus/Gencode/M25/GRCm38.p6.genome.fa \
--gtf /scratch/Shares/rinn/genomes/Mus_musculus/Gencode/M25/gencode.vM25.annotation.gtf \
--macs_gsize 1.87e9 \
--blacklist mm10-blacklist.v2.bed \
--igg_control false \
--email michael.smallegan@colorado.edu \
-resume \
-c nextflow.config
date
