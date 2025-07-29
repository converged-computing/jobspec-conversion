#!/bin/bash
#SBATCH --job-name=sector-coupled-euro-calliope-eurospores-3h
#SBATCH --account=research-tpm-ess
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=96G
#SBATCH --time=04:00:00

cd ..;
conda activate eurocalliope_2022_02_08;
srun snakemake --use-conda --profile default "build/eurospores/outputs/2016_res_3h.nc"
