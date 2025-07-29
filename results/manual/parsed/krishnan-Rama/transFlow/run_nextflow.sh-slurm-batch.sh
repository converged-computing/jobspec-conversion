#!/bin/bash
#SBATCH --job-name=nf-deploy
#SBATCH --output=logs/%J.out
#SBATCH --error=logs/%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --partition=<HPC

module load singularity/3.8.7
module load nextflow/23.04.1
nextflow run main.nf -profile cluster -resume
