#!/bin/bash
#SBATCH --job-name=Nextflow-master-BLAST
#SBATCH --account=pawsey0001
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=workq

module load singularity  # just in case image pull is needed
module load nextflow
nextflow run blast.nf -profile zeus
ls -ltr
