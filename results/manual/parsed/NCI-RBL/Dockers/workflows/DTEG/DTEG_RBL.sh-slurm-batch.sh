#!/bin/bash
#SBATCH --job-name=DTEG
#SBATCH --mail-user=guibletwm
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=200g
#SBATCH --time=2-00:00:00

module load nextflow
module load singularity
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process AlignRNA
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process RunRiboSeq
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process RunHTseq
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process MergeCounts
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process DTEG
