#!/bin/bash
#FLUX: --job-name=faux-eagle-2361
#FLUX: --urgency=16

module load singularity
gunzip -c /projects/rosenthal-lab/cube/genetic_demultiplexing/sc-data-rerun/cube_rna/$1/cellranger/filtered_feature_bc_matrix/barcodes.tsv.gz > /projects/rosenthal-lab/cube/genetic_demultiplexing/sc-data-rerun/cube_rna/$1/cellranger/filtered_feature_bc_matrix/barcodes.tsv
nextflow run mainSoupCellRna.nf --samplename $1 --outdir $1 --isAtac False --souporcellSif /projects/koharv/singularityImages/souporcell.sif --input /projects/rosenthal-lab/cube/genetic_demultiplexing/sc-data-rerun/cube_rna/$1/cellranger/possorted_genome_bam.bam --barcode /projects/rosenthal-lab/cube/genetic_demultiplexing/sc-data-rerun/cube_rna/$1/cellranger/filtered_feature_bc_matrix/barcodes.tsv --fasta /projects/rosenthal-lab/cube/genetic_demultiplexing/sc-data-rerun/refdata-gex-mm10-2020-A/fasta/genome.fa --vcf /projects/rosenthal-lab/cube/genetic_demultiplexing/vivek/souporcell/cube_3bears_atac.vcf
