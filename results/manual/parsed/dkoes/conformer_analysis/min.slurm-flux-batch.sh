#!/bin/bash
#FLUX: --job-name=minrd
#FLUX: --queue=any_cpu
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
cmd=`sed -n "${SLURM_ARRAY_TASK_ID}p" minsdf`
eval $cmd
