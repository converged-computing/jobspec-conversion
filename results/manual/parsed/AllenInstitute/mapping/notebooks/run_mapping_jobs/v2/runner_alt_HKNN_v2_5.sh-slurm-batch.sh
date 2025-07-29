#!/bin/bash
#FLUX: --job-name=a;t_HKNN_v2_5_job
#FLUX: --queue=celltypes
#FLUX: -t=864000
#FLUX: --urgency=16

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/alt_v2_HKNN_5.R > logfiles/alt_HKNN_v2_5_logfile
