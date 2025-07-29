#!/bin/bash
#SBATCH --job-name=multiomics_nextflow
#SBATCH --output=multiomics_%j_output.txt
#SBATCH --error=multiomics_%j_error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=128GB
#SBATCH --time=8-08:00:00

nextflow run multiomics_nextflow.nf.groovy --data $1 --data_labels $2
