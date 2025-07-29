#!/bin/bash
#SBATCH --job-name=ont_barcoding
#SBATCH --account=snic2022-5-42
#SBATCH --output=logs/snakemake-%j.log
#SBATCH --error=logs/snakemake-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=02:00:00
#SBATCH --constraint=usage_mail

module load conda bioinfo-tools snakemake &&
snakemake -pr --jobs $SLURM_JOB_CPUS_PER_NODE\
    --use-envmodules\
    --use-conda\
    --conda-frontend conda\
    --shadow-prefix /scratch\
    all_hac
