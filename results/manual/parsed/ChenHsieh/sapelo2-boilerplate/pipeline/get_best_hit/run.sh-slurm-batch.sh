#!/bin/bash
#SBATCH --job-name=razi
#SBATCH --output=razi.%j.out
#SBATCH --error=razi.%j.err
#SBATCH --mail-user=youremail@uga.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=64gb
#SBATCH --time=04:00:00
#SBATCH --partition=batch

date
ml Anaconda3
ml snakemake
ml DIAMOND
cd $SLURM_SUBMIT_DIR
conda init bash
source ~/.bashrc
conda activate snakemake
snakemake --cores all
date
