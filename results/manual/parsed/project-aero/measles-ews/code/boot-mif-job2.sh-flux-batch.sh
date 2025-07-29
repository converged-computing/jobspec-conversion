#!/bin/bash
#FLUX --job-name=blue-cat-8536
#FLUX -t=86400
#FLUX --urgency=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID bootstrap-fit-mif.R
