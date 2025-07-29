#!/bin/bash
#SBATCH --account=iidd
#SBATCH --output=shellLog/slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60GB
#SBATCH --time=2-00:00:00

module load singularity
srun singularity exec national-data-pulls_v0.1.sif Rscript -e '
library(scipiper);
options(scipiper.getters_file = "remake.yml"); 
scmake("30_data_summarize")'
