#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --account=COVIRT19
#SBATCH --output=output.%j
#SBATCH --error=error.%j
#SBATCH --mail-user=kternus@signaturescience.com
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=skx-normal
#SBATCH --qos=vip

export SINGULARITY_BINDPATH='data:/tmp'

module load tacc-singularity
module list
umask 0007
conda activate metag
export SINGULARITY_BINDPATH="data:/tmp"
snakemake --cores --use-singularity --configfile=config/my_custom_config.json tax_class_bracken_workflow > snakemake.${SLURM_JOBID}.log 2>&1
