#!/bin/bash
#FLUX: --job-name=conspicuous-pedo-0062
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load singularity
singularity exec ../../../Containers/R.sif R -e 'rmarkdown::render(here::here("Documents", "LPS_Sensitivity.Rmd"))'
