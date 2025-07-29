#!/bin/bash
#SBATCH --job-name=run_wrkflw
#SBATCH --output=run%J.out
#SBATCH --error=run%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --partition=htc

module load singularity
module load nextflow
nextflow run xas_main.nf -profile slurm_singularity
