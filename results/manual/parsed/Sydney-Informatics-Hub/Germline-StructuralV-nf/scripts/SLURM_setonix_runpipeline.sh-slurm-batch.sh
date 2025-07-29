#!/bin/bash
#SBATCH --job-name=GSV
#SBATCH --account=XXXX
#SBATCH --mail-user=XXXX
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000M
#SBATCH --time=10:00:00
#SBATCH --partition=work

module load singularity/3.8.6-nompi
module load nextflow/22.04.3
nextflow run main.nf --input samples.tsv --ref /path/to/reference/fasta -config config/setonix.config --annotsv Annotations_Human
