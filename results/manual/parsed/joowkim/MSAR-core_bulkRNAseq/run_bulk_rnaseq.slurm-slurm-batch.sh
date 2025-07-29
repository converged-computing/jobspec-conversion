#!/bin/bash
#SBATCH --job-name=nf-bulk_rnaseq
#SBATCH --output=mrnaseq.%A.o
#SBATCH --error=mrnaseq.%A.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=1-00:00:00
#SBATCH --partition=defq

module load nextflow/22.04.3
module load singularity/3.8.0
nextflow run bulk_rnaseq.nf -c ./bulk_rnaseq_conf/run.config -resume -profile slurm
module unload nextflow/22.04.3
module unload singularity/3.8.0
