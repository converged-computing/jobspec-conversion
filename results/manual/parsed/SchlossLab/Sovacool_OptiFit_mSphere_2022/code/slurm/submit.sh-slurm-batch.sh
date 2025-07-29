#!/bin/bash
#SBATCH --job-name=OptiFit
#SBATCH --account=YOUR_ACCOUNT
#SBATCH --output=log/hpc/slurm-%j_%x.out
#SBATCH --mail-user=YOUR_EMAIL
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50MB
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=1

time snakemake --profile config/slurm --latency-wait 90
