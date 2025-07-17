#!/bin/bash
#FLUX: --job-name=stinky-arm-2052
#FLUX: -n=29
#FLUX: --queue=batch
#FLUX: -t=174000
#FLUX: --urgency=16

module load singularity
mkdir $1
nextflow run mainSoupCellAtac.nf --samplename $1 --outdir $1 --isAtac True --souporcellSif /projects/koharv/singularityImages/souporcell.sif --input /projects/rosenthal-lab/cube/genetic_demultiplexing/sc-data-rerun/cube_atac_2021/$1/cellranger/possorted_bam.bam --barcode /projects/rosenthal-lab/cube/genetic_demultiplexing/sc-data-rerun/cube_atac_2021/$1/cellranger/filtered_peak_bc_matrix/barcodes.tsv --fasta /projects/rosenthal-lab/cube/genetic_demultiplexing/sc-data-rerun/refdata-gex-mm10-2020-A/fasta/genome.fa --vcf /projects/rosenthal-lab/cube/genetic_demultiplexing/vivek/souporcell/cube_3bears_atac.vcf
