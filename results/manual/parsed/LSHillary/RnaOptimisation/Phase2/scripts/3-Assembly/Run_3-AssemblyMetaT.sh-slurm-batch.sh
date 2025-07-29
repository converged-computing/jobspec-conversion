#!/bin/bash
#SBATCH --job-name=RnaOpt-preprocessing
#SBATCH --output=logs/RnaOpt-preprocessing_%j.out
#SBATCH --error=logs/RnaOpt-preprocessing_%j.err
#SBATCH --mail-user=lhillary@ucdavis.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=5-10:00:00

source ~/.bashrc
cd MetaT
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/3-Assembly/3-Assembly_MetaT.smk --profile slurm --rerun-triggers mtime
