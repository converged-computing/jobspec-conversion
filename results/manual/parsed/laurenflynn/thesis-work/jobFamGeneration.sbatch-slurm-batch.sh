#!/bin/bash
#SBATCH --job-name=generateFamilies
#SBATCH --output=slurm_log_files/family_generation/10000families_%A_%a.out
#SBATCH --error=slurm_log_files/family_generation/10000families_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --time=1-00:12:00

singularity exec --cleanenv --env R_LIBS_USER=$HOME/R/ifxrstudio/RELEASE_3_15 /n/singularity_images/informatics/ifxrstudio/ifxrstudio:RELEASE_3_15.sif Rscript src/1_generate_families_separate_dfs.R   
