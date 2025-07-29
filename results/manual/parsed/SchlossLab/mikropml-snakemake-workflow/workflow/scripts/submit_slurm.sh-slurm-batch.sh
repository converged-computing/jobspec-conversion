#!/bin/bash
#SBATCH --job-name=mikropml
#SBATCH --account=YOUR_ACCOUNT_HERE
#SBATCH --output=log/hpc/slurm-%j_%x.out
#SBATCH --mail-user=YOUR_EMAIL_HERE
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100MB
#SBATCH --time=4-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

module load singularity 
snakemake --profile config/slurm --latency-wait 90 --use-singularity --use-conda --conda-frontend mamba --configfile config/test.yaml 
