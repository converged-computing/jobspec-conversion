#!/bin/bash
#FLUX: --job-name=alteredHKNN_lists_job
#FLUX: -n=50
#FLUX: --queue=celltypes
#FLUX: -t=1296000
#FLUX: --urgency=16

singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/example_run_mapping_hknn.R > logfiles/alteredHKNN_lists_logfile
