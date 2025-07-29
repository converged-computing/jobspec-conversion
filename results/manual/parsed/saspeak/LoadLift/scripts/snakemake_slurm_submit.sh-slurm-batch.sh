#!/bin/bash
#SBATCH --job-name=Snakemake_submission
#SBATCH --output=Snakemake_%j.log
#SBATCH --error=Snakemake_%j.err
#SBATCH --mail-user=hgg16hgu@uea.ac.uk
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=1-00:00:00

source activate snakemake
snakemake --slurm --default-resources slurm_account=cropdiv-acc slurm_partition=short -s ${1} ${3} -j ${2} --use-conda --rerun-incomplete 
source deactivate
