#!/bin/bash
#FLUX: --job-name=cluster_transcripts
#FLUX: -t=1440
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load singularity
singularity exec ../../../Containers/R.sif R -e 'rmarkdown::render(here::here("Documents", "3a.High_Dimensional_Mediation.Rmd"))'
