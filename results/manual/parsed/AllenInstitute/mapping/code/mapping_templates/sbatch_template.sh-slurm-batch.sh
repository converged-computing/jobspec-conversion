#!/bin/bash
#FLUX: --job-name=ENTER_DESIRED_NAME_job
#FLUX: --queue=celltypes
#FLUX: -t=864000
#FLUX: --urgency=16

singularity exec docker://alleninst/mapping_on_hpc Rscript ENTER_R_SCRIPT_NAME.R > ENTER_DESIRED_NAME_logfile
