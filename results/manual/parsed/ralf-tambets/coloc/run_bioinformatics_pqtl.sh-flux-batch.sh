#!/bin/bash
#FLUX: --job-name=eccentric-hobbit-0143
#FLUX: --queue=main
#FLUX: --urgency=16

module load any/jdk/1.8.0_265
module load nextflow
module load any/singularity/3.7.3
module load squashfs/4.4
cwd=$(pwd)
nextflow run main_pqtl.nf \
    -profile tartu_hpc \
    --eqtl_tsv $cwd/bioinformatics_example/bioinformatics_eqtl.tsv \
    --pqtl_tsv $cwd/bioinformatics_example/bioinformatics_pqtl.tsv \
    --chromosomes 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X \
    --n_chromosomes 23 \
    --chr_batches 1 \
    --metadata_file $cwd/bioinformatics_example/bioinformatics_data/gene_counts_Ensembl_105_phenotype_metadata.tsv.gz \
    -w $cwd/work_bioinformatics_pqtl \
    --outdir $cwd/results_bioinformatics_pqtl \
    -resume
