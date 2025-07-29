#!/bin/bash
#SBATCH --job-name=nextflow
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --qos=general

module load nextflow/22.04.0
nextflow run main.nf -entry NF_GWAS -resume -with-singularity gwas-nf.sif
