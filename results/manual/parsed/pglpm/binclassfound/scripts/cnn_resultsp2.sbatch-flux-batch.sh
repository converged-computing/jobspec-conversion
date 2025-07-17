#!/bin/bash
#FLUX: --job-name=RESP2
#FLUX: --queue=normal
#FLUX: -t=2700
#FLUX: --urgency=16

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module --quiet purge
module load R/4.1.2-foss-2021b
cd ~/binclassfound
Rscript cnn_mcmcp_2.R $SLURM_ARRAY_TASK_ID > cnn_mcmcp_2_$SLURM_ARRAY_TASK_ID.Rout 2>&1
