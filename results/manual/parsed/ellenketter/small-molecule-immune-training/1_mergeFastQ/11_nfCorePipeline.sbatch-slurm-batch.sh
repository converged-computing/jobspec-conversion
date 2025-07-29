#!/bin/bash
#SBATCH --job-name=nfcore
#SBATCH --account=pi-lbarreiro
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100GB
#SBATCH --time=1-00:00:00

export PATH='$PATH:/project/lbarreiro/USERS/ellen/programs/FastQC/'

export PATH=$PATH:/project/lbarreiro/USERS/ellen/programs/
export PATH=$PATH:/project/lbarreiro/USERS/ellen/programs/FastQC/
module load java
cd /project/lbarreiro/USERS/ellen/KnightMolecules/analysis/
nextflow run nf-core/atacseq --input samplesheet.csv --outdir 11_mergeFastQ/ --genome GRCm38 --read_length 50 -r 2.0
