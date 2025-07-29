#!/bin/bash
#SBATCH --job-name=HUVEC
#SBATCH --output=%j_%x.out
#SBATCH --error=%j_%x.err
#SBATCH --mail-user=<your-email>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G
#SBATCH --time=3-12:00:00

source /path/to/baseenv/bin/activate re
snakemake --configfile=config/endothelial-cell-of-umbilical-vein.yaml all --cores 2 --unlock
snakemake --configfile=config/endothelial-cell-of-umbilical-vein.yaml all --cores 2 --rerun-incomplete
