#!/bin/bash
#FLUX: --job-name=HKNN_v3_10_job
#FLUX: --queue=celltypes
#FLUX: -t=864000
#FLUX: --urgency=16

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/cont_v3_HKNN_10.R > logfiles/HKNN_v3_10_logfile
