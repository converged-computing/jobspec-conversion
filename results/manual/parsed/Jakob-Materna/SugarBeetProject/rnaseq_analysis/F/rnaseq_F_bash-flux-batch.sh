#!/bin/bash
#FLUX: --job-name=buttery-avocado-2481
#FLUX: -c=48
#FLUX: --priority=16

cat $0
module load Nextflow/23.10.0
cd /home/materna/lu2023-12-14/Students/Jakob/merged/F
nextflow run nf-core/rnaseq \
    --input /home/materna/lu2023-12-14/Students/Jakob/merged/F/samplesheet_F.csv \
    --outdir /home/materna/lu2023-12-14/Students/Jakob/merged/F/nfcore \
    --fasta /home/materna/lu2023-12-14/Students/Jakob/merged/reference/merged/merged.fa \
    --gtf /home/materna/lu2023-12-14/Students/Jakob/merged/reference/merged/merged.gtf \
    --skipQC \
    --skip_biotype_qc \
    --skip_markduplicates \
    --skip_bigwig \
    --skip_stringtie \
    --skip_preseq \
    --skip_dupradar \
    --skip_qualimap \
    --skip_rseqc \
    --skip_deseq2_qc \
    --skip_multiqc \
    --max_cpus 48 \
    --max_memory 254GB \
    -profile singularity 
