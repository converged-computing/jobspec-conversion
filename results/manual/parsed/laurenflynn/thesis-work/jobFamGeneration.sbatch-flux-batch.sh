#!/bin/bash
#FLUX: --job-name=chunky-hobbit-9501
#FLUX: --urgency=16

singularity exec --cleanenv --env R_LIBS_USER=$HOME/R/ifxrstudio/RELEASE_3_15 /n/singularity_images/informatics/ifxrstudio/ifxrstudio:RELEASE_3_15.sif Rscript src/1_generate_families_separate_dfs.R   
