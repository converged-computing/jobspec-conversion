#!/bin/bash
#SBATCH --job-name=cutadapt
#SBATCH --output=cutadapt.out
#SBATCH --error=cutadapt.err
#SBATCH --mail-user=daned@uoregon.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=28

ml easybuild ifort/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132
ml cutadapt/1.14-Python-2.7.13
dir=/home/daned/bi624/ps1/
cutadapt -a GATCGGAAGAGCACACGTCTGAACTCCAGTCAC -A GATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o /home/daned/bi624/ps1/cutadapt_data/trimmed_8_2F_fox_R1_001.fastq 
-p /home/daned/bi624/ps1/cutadapt_data/trimmed_8_2F_fox_R2_001.fastq $dir/8_2F_fox_S7_L008
_R1_001.fastq $dir/8_2F_fox_S7_L008_R2_001.fastq
cutadapt -a GATCGGAAGAGCACACGTCTGAACTCCAGTCAC -A GATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o /
home/daned/bi624/ps1/cutadapt_data/trimmed_31_4F_fox_R1_001.fastq 
-p /home/daned/bi624/ps1/cutadapt_data/trimmed_31_4F_fox_R2_001.fastq $dir/31_4F_fox_S22_
L008_R1_001.fastq $dir/31_4F_fox_S22_L008_R2_001.fastq
