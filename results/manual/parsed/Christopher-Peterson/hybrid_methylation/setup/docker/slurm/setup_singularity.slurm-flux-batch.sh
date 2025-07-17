#!/bin/bash
#FLUX: --job-name=setup_singularity
#FLUX: --queue=development
#FLUX: -t=1200
#FLUX: --urgency=16

cdw singularity
ml tacc-singularity
module unload xalt
singularity pull -F docker://crpeters/trim_galore:0.6.7 &
singularity pull -F docker://crpeters/bedtools &
singularity pull -F docker://biopython/biopython:latest &
singularity pull -F docker://crpeters/r-tidyverse-optparse:4.2.1 &
singularity pull -F docker://crpeters/r-plotting:4.2.1 &
singularity pull -F docker://biocontainers/pysam:v0.15.2ds-2-deb-py3_cv1 &
singularity pull  --name nfcore-methylseq-1.6.1.img docker://nfcore/methylseq:1.6.1 &
singularity pull -F docker://crpeters/angsd:0.940-stable &
singularity pull -F docker://staphb/bcftools:1.16 &
singularity pull -F docker://crpeters/edge-trait-meta:4.2.0 &
singularity pull -F docker://crpeters/r-methylkit:4.2.1 &
source $WORK/singularity/singularity_mask.sh
singularity_mask bedtools $WORK/singularity/bedtools_latest.sif
singularity_mask bismark $WORK/singularity/nfcore-methylseq-1.6.1.img
singularity_mask bowtie2 $WORK/singularity/nfcore-methylseq-1.6.1.img
singularity_mask bowtie2-build $WORK/singularity/nfcore-methylseq-1.6.1.img
singularity_mask samtools $WORK/singularity/nfcore-methylseq-1.6.1.img
singularity_mask bgzip $WORK/singularity/nfcore-methylseq-1.6.1.img
singularity_mask tabix $WORK/singularity/nfcore-methylseq-1.6.1.img
singularity_mask bismark_genome_preparation $WORK/singularity/nfcore-methylseq-1.6.1.img
singularity_mask deduplicate_bismark $WORK/singularity/nfcore-methylseq-1.6.1.img
singularity_mask bismark_methylation_extractor $WORK/singularity/nfcore-methylseq-1.6.1.img
singularity_mask cutadapt $WORK/singularity/trim_galore_0.6.7.sif
singularity_mask trim_galore $WORK/singularity/trim_galore_0.6.7.sif
singularity_mask fastqc $WORK/singularity/trim_galore_0.6.7.sif
singularity_mask angsd $WORK/singularity/angsd_0.940-stable.sif
singularity_mask bcftools $WORK/singularity/bcftools_1.16.sif
singularity_mask biopython $WORK/singularity/biopython_latest.sif python3
singularity_mask r-tidy-opt $WORK/singularity/r-tidyverse-optparse_4.2.1.sif Rscript
singularity_mask r-plotting $WORK/singularity/r-plotting_4.2.1.sif Rscript
singularity_mask r-methylkit $WORK/singularity/r-methylkit_4.2.1.sif Rscript
singularity_mask r-brms $WORK/singularity/edge-trait-meta_4.2.0.sif Rscript
