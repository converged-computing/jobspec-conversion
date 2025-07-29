#!/bin/bash
#SBATCH --job-name=cor_vis_sub
#SBATCH --output=VISION_cor_sub.out
#SBATCH --error=VISION_cor_sub.err
#SBATCH --mail-user=jwhitlock@uab.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=255000
#SBATCH --time=12:00:00

export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3'

module load Singularity/3.5.2-GCC-5.4.0-2.26
wd="/data/user/jbarham3/230227_JW_Setbp1Manuscript"
src="/data/user/jbarham3/230227_JW_Setbp1Manuscript/src/module_scores" #be sure that your subdirectories are structured the same
export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3'
cd ${wd}
singularity exec --cleanenv --no-home -B ${wd} ${wd}/bin/docker/setbp1_manuscript_1.0.11.sif Rscript --vanilla ${src}/01_Setbp1_vision_subset_cortex.R # here vanilla ensures only the script is run and environment is kept clean
