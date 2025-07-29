#!/bin/bash
#SBATCH --job-name=QCing
#SBATCH --output=qc.%A.o
#SBATCH --error=qc.%A.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=12:00:00
#SBATCH --partition=defq

module load nextflow/22.04.3
module load singularity/3.8.0
nextflow run qc.nf -c ./conf/run.config -resume -profile slurm
module unload nextflow/22.04.3
module unload singularity/3.8.0
