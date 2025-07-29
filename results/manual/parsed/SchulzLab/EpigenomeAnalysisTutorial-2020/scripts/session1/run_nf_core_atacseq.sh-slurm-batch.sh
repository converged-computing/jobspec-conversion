#!/bin/bash
#SBATCH --job-name=preprocessing
#SBATCH --account=rwth0233
#SBATCH --output=./preprocessing.txt
#SBATCH --error=./preprocessing.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=180G
#SBATCH --time=5-00:00:00

source ~/.zshrc
conda activate nf-core-atacseq-1.2.1
prefetch -v SRR3689759
prefetch -v SRR3689760
prefetch -v SRR3689933	
prefetch -v SRR3689934	
fastq-dump --split-files --gzip /hpcwork/izkf/ncbi/sra/SRR3689759.sra
fastq-dump --split-files --gzip /hpcwork/izkf/ncbi/sra/SRR3689760.sra
fastq-dump --split-files --gzip /hpcwork/izkf/ncbi/sra/SRR3689933.sra
fastq-dump --split-files --gzip /hpcwork/izkf/ncbi/sra/SRR3689934.sra
/home/rs619065/miniconda3/bin/nextflow run nf-core/atacseq --input design.csv --genome hg38 --narrow_peak 
