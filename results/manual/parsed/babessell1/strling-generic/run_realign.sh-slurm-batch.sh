#!/bin/bash
#SBATCH --job-name=realign
#SBATCH --account=remills1
#SBATCH --output=logs/realign.out
#SBATCH --error=logs/realign.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=2-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=12

eval "$(conda shell.bash hook)"
conda init bash
conda activate snake
module load Bioinformatics
module load samtools
snakemake -s realign.smk --unlock
snakemake -s realign.smk --rerun-incomplete --cores 12
