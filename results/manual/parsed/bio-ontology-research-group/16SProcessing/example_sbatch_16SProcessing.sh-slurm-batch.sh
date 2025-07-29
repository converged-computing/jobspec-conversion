#!/bin/bash
#SBATCH --job-name=16S_NF
#SBATCH --output=16S_NF.%J.out
#SBATCH --error=16S_NF.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=10G
#SBATCH --time=02:00:00

module load nextflow
module load singularity
nextflow run 16SProcessing.nf --in_dir directory/with/fastq/files -profile singularity
