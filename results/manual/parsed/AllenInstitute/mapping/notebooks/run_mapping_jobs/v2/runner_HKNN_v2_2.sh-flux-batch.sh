#!/bin/bash
#FLUX: --job-name=HKNN_v2_2_job
#FLUX: --queue=celltypes
#FLUX: -t=864000
#FLUX: --urgency=16

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/cont_v2_HKNN_2.R > logfiles/HKNN_v2_2_logfile
