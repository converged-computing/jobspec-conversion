#!/bin/bash
#SBATCH --job-name=ont_barcoding_2023
#SBATCH --account=naiss2023-5-37
#SBATCH --output=logs/snakemake-%j.log
#SBATCH --error=logs/snakemake-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=core
#SBATCH --constraint=usage_mail

module load conda bioinfo-tools snakemake &&
snakemake -pr --jobs $SLURM_JOB_CPUS_PER_NODE\
    --use-envmodules\
    --use-conda\
    --conda-frontend conda\
    --shadow-prefix /scratch
chmod -R g+rwX .snakemake/metadata &>/dev/null
