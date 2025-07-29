#!/bin/bash
#SBATCH --job-name=moa
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=1-00:00:00
#SBATCH --partition=main
#SBATCH --constraint=ntasks-per-node=1

export root='/gpfs/space/home/dzvenymy'

module load any/jdk/1.8.0_265
module load any/singularity/3.7.3
module load squashfs/4.4
module load nextflow
export root=/gpfs/space/home/dzvenymy
nextflow main.nf  --in_file "${root}/qtl_labeling/moa_data/full_dataset_with_labeled_eqtls_and_negatives.csv"  --HOME $root --cell_type 156 \
                --out_dir "${root}/Thesis/nextflow_output_full_dataset_cropped_enformer"
