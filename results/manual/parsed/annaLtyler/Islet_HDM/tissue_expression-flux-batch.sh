#!/bin/bash
#FLUX: --job-name=swampy-milkshake-9443
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module load singularity
singularity exec ../../../Containers/R.sif R -e 'rmarkdown::render(here::here("Documents", "1a.Tissue_Expression.Rmd"))'
