#!/bin/bash
#SBATCH --job-name=multiqc
#SBATCH --output=before-fastp-multiqc-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=100GB

cd /home/tly/wgs-pika/results/multiqc/
module purge
module load intel-python3
multiqc /home/tly/wgs-pika/results/before-fastp-fastqc/
