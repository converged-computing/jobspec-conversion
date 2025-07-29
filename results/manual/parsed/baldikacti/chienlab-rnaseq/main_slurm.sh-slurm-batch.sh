#!/bin/bash
#SBATCH --job-name=chienlab-rnaseq-ba
#SBATCH --output=logs/chienlab-rnaseq-ba_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32gb
#SBATCH --time=06:00:00
#SBATCH --partition=cpu

date;hostname;pwd
module load nextflow/23.04.1 miniconda/22.11.1-1
nextflow run main_dev.nf \
    --data_dir data/test/raw \
    --sample_file data/test/reference.tsv \
    --ref_genome references/NC_011916.fasta \
    --ref_ann references/ccna.gff \
    --outdir results/test \
    -profile conda \
    -resume
date
