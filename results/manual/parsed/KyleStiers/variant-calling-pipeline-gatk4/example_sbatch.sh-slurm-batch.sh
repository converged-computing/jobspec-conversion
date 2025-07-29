#!/bin/bash
#SBATCH --job-name=nf-custom-gat4k
#SBATCH --output=nf_custom_gatk4-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50G
#SBATCH --time=00:10:00
#SBATCH --partition=Lewis

nextflow run KyleStiers/variant-calling-pipeline-gatk4 -with-singularity KyleStiers/variant-calling-pipeline-gatk4
