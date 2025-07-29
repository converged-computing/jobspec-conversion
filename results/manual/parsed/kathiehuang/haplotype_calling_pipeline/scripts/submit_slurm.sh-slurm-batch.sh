#!/bin/bash
#SBATCH --job-name=haplotype_calling_pipeline
#SBATCH --output=logs/output_%j.out
#SBATCH --error=logs/output_%j.err
#SBATCH --mail-user=<YOUR_EMAIL_HERE>
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=24-00:00:00

echo "$SLURM_ARRAY_TASK_ID"
snakemake --cores 12 --stats output/stats
