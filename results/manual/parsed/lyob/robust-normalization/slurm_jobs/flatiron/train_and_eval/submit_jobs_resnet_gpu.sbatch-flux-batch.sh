#!/bin/bash
#FLUX: --job-name=resnorm
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

ARRAY_ID=$1
PARAMETER_FILE=$2
let FILE_LINE=($ARRAY_ID + $SLURM_ARRAY_TASK_ID)
echo "Line ${FILE_LINE}"
PARAMETERS=$(sed "${FILE_LINE}q;d" ${PARAMETER_FILE})
echo ${PARAMETERS}
bash run_code_resnet.sh ${PARAMETERS}
