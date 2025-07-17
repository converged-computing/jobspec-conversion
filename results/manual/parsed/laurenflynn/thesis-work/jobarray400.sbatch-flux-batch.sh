#!/bin/bash
#FLUX: --job-name=generateFamilies
#FLUX: --queue=serial_requeue
#FLUX: -t=750
#FLUX: --urgency=16

singularity exec --cleanenv --env R_LIBS_USER=$HOME/R/ifxrstudio/RELEASE_3_15 /n/singularity_images/informatics/ifxrstudio/ifxrstudio:RELEASE_3_15.sif Rscript src/2_slurm_with_loops.R ${SLURM_ARRAY_TASK_ID}
