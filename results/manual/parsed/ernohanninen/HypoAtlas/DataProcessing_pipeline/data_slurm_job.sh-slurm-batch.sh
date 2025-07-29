#!/bin/bash
#SBATCH --job-name=data
#SBATCH --output=any_name_%j.log
#SBATCH --mail-user=erno.hanninen@sund.ku.dk
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=30gb
#SBATCH --time=05:00:00

module load java/11.0.15 nextflow
nextflow run data_processing_wf.nf
