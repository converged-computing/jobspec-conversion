#!/bin/bash
#FLUX: --job-name=HKNN_v2_50_job
#FLUX: --queue=celltypes
#FLUX: -t=864000
#FLUX: --urgency=16

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/v2_HKNN_50.R > logfiles/HKNN_v2_50_logfile
