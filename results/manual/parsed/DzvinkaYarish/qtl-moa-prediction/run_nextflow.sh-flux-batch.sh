#!/bin/bash
#FLUX: --job-name="moa"
#FLUX: -c=4
#FLUX: --queue=main
#FLUX: -t=86400
#FLUX: --priority=16

export root='/gpfs/space/home/dzvenymy'

module load any/jdk/1.8.0_265
module load any/singularity/3.7.3
module load squashfs/4.4
module load nextflow
export root=/gpfs/space/home/dzvenymy
nextflow main.nf  --in_file "${root}/qtl_labeling/moa_data/full_dataset_with_labeled_eqtls_and_negatives.csv"  --HOME $root --cell_type 156 \
                --out_dir "${root}/Thesis/nextflow_output_full_dataset_cropped_enformer"
