#!/bin/bash
#SBATCH --job-name=snake
#SBATCH --output=snake.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=5G
#SBATCH --time=1-00:00:00
#SBATCH --partition=ycga

module load miniconda
conda activate isoseq
snakemake --snakefile isoseq.smk --cores $SLURM_CPUS_PER_TASK --config species=Cyanea_sp transcriptome=W7.clustered.hq.fasta
