#!/bin/bash
#FLUX: --job-name=2023_HEPG2_rna_seq
#FLUX: --queue=long
#FLUX: -t=72000
#FLUX: --urgency=16

pwd; hostname; date
echo "Here we go You've requested $SLURM_CPUS_ON_NODE core."
module load singularity/3.1.1
nextflow run nf-core/rnaseq -r 1.4.2 \
-resume \
-profile singularity \
--reads '/scratch/Shares/rinnclass/CLASS_2023/JR/CLASS_2023/CLASSES/05_R_analyses/analysis/05_RNAseq/00_RNAseq_download_NF_core_pipeline/data/fastq/*{_read1,_read2}.fastq.gz' \
--fasta /scratch/Shares/rinnclass/CLASS_2023/data/data/genomes/GRCh38.p13.genome.fa \
--gtf /scratch/Shares/rinnclass/CLASS_2023/data/data/genomes/gencode.v32.annotation.gtf \
--pseudo_aligner salmon \
--gencode \
--email john.rinn@colorado.edu \
-c nextflow.config
date
