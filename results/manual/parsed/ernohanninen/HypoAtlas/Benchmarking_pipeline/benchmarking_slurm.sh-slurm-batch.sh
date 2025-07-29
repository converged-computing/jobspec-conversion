#!/bin/bash
#SBATCH --job-name=integration
#SBATCH --output=any_name_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=300gb
#SBATCH --time=4-00:00:00

module load java/11.0.15 nextflow
nextflow run main.nf -c pipeline.config
