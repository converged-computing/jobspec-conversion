#!/bin/bash
#SBATCH --job-name=TKU4354_subsampling
#SBATCH --output=./logs/TKU4354_subsampling.log
#SBATCH --error=./logs/TKU4354_subsampling.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G
#SBATCH --partition=pe2

module load seqtk
cd /gpfs/commons/groups/landau_lab/rraviram/Suva_lab_GBM/Splicing_ONT/ONT_Splicing_TKU4354/input_files/1.ONT_fastq/
seqtk sample TKU4354.fastq 5000000 > TKU4354_subsample_5b.fastq
