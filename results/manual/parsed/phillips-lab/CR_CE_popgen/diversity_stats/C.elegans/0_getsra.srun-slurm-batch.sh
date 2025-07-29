#!/bin/bash
#SBATCH --job-name=sra
#SBATCH --account=phillipslab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=phillips
#SBATCH --array=0-27

module load easybuild sratoolkit/2.8.2-1
SRA=$(sed -n $((${SLURM_ARRAY_TASK_ID}+1))p SRA.txt)
fastq-dump --split-files $SRA
