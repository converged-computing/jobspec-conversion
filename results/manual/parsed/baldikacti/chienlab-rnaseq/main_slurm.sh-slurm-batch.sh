#!/bin/bash
#FLUX: --job-name=chienlab-rnaseq-ba
#FLUX: -n=8
#FLUX: --queue=cpu
#FLUX: -t=21600
#FLUX: --urgency=16

date;hostname;pwd
module load nextflow/23.04.1 miniconda/22.11.1-1
nextflow run main_dev.nf \
    --data_dir data/test/raw \
    --sample_file data/test/reference.tsv \
    --ref_genome references/NC_011916.fasta \
    --ref_ann references/ccna.gff \
    --outdir results/test \
    -profile conda \
    -resume
date
