#!/bin/bash
#FLUX: --job-name=covstates
#FLUX: -c=32
#FLUX: --queue=covid19_p
#FLUX: -t=259200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load R/3.6.2-foss-2019b
mkdir ${SLURM_JOB_ID}
cd ${SLURM_JOB_ID}
R CMD BATCH "--args a=$SLURM_ARRAY_TASK_ID" ../code/00-RUN-CLUSTER-ARRAY.R
