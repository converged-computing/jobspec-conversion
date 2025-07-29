#!/bin/bash
#FLUX: --job-name=fst
#FLUX: -c=10
#FLUX: --queue=standard
#FLUX: -t=900
#FLUX: --urgency=16

  module load intel/18.0 intelmpi/18.0 R/4.0.3
  Rscript --vanilla FULL_PATH_TO-outFLANK_Fst.R ${SLURM_ARRAY_TASK_ID}
