#!/bin/bash
#FLUX: --job-name=glimpse
#FLUX: --queue=amd
#FLUX: -t=86400
#FLUX: --priority=16

module load nextflow/22.04.3
module load any/singularity/3.11.1
nextflow -log logs/.nextflow.log run main.nf -profile tartu_hpc \
    --samples /path/to/samples.tsv \
    --chromosomes 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22 \
    --reference_panel /gpfs/space/projects/genomic_references/imputation/glimpse_reference_070223/reference_panel/1kGP_high_coverage_Illumina.all.filtered.SNV_INDEL_SV_phased_panel.no_chr.independent_inds.vcf.gz \
    --reference_genome /gpfs/space/projects/genomic_references/imputation/glimpse_reference_070223/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
    --genetic_map /gpfs/space/projects/genomic_references/imputation/glimpse_reference_070223/genetic_map.b38 \
    --outdir ./results \
