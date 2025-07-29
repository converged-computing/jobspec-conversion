#!/bin/bash
#SBATCH --job-name=hisat2index
#SBATCH --output=build_indexes_hisat2.out
#SBATCH --error=build_indexes_hisat2.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=40gb
#SBATCH --time=04:05:00

module load hisat2/2.1.0
IN=/scratch/Users/mame5141/2019/RNAseq-Biome-Nextflow/ensembl
FA=Homo_sapiens.GRCh38.dna.primary_assembly.fa
mkdir -p ${IN}/hisat2_index
hisat2-build -p 16 ${IN}/${FA} ${IN}/hisat2_index/genome
