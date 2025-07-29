#!/bin/bash
#FLUX: --job-name=ftc-rnaseq
#FLUX: --queue=long
#FLUX: -t=360000
#FLUX: --urgency=16

pwd; hostname; date
echo "You've requested $SLURM_CPUS_ON_NODE core."
module load singularity/3.1.1
nextflow run nf-core/rnaseq -r 3.8.1 \
-resume \
-profile singularity \
--outdir /scratch/Shares/rinn/Michael/firre_timecourse/rnaseq1/results \
--input 'rnaseq_samples.csv' \
--fasta ../../../genomes/Mus_musculus/Gencode/M25/GRCm38.p6.genome.fa \
--gtf ../../../genomes/Mus_musculus/Gencode/M25/gencode.vM25.annotation.gtf \
--aligner star_salmon \
--gencode \
--skip_qc \
--email michael.smallegan@colorado.edu \
-c nextflow.config
date
