#!/bin/bash
#FLUX: --job-name=ALT_HKNN_v3_5_job
#FLUX: --queue=celltypes
#FLUX: -t=864000
#FLUX: --urgency=16

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/v3_HKNN_5_ALT.R > logfiles/v3_HKNN_5_ALT_logfile
