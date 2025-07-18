#!/bin/bash
#FLUX: --job-name=group1
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --urgency=16

pwd; hostname; date
echo "Booyakasha, Big up Yaself -- you've requested $SLURM_CPUS_ON_NODE core."
module load singularity/3.1.1
nextflow run nf-core/chipseq -r 1.1.0 \
-profile singularity \
--input design.csv \
--fasta /Shares/rinn_class/data/genomes/human/gencode/v32/GRCh38.p13.genome.fa \
--gtf /Shares/rinn_class/data/genomes/human/gencode/v32/gencode.v32.annotation.gtf \
--macs_gsize 2.7e9 \
--blacklist hg38-blacklist.v2.bed \
--save_reference \
--email deta9300@colorado.edu \
-resume \
-c nextflow.config
date
