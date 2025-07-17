#!/bin/bash
#FLUX: --job-name=v100-arrayjob
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

JOB_FILE=$1
EXTRA_ARGS=${@:2}
JOB=`sed -n ${SLURM_ARRAY_TASK_ID}p ${JOB_FILE}`
echo $JOB $EXTRA_ARGS
$JOB $EXTRA_ARGS
