#!/bin/bash
#FLUX: --job-name=HKNN_SS_odd_job
#FLUX: --queue=celltypes
#FLUX: -t=864000
#FLUX: --urgency=16

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/SS_odd_jobs.R > logfiles/HKNN_SS_odd_logfile
