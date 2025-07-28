#!/bin/bash
#FLUX: --job-name=el-id
#FLUX: -c=8
#FLUX: -t=180
#FLUX: --urgency=16

export VAR='$SLURM_ARRAY_TASK_ID'

export VAR=$SLURM_ARRAY_TASK_ID
export SCRIPT_VAR
SIF=/opt/tmp/godin/sing_images/tf-2.1.0-gpu-py3_sing-2.6.sif
singularity shell --nv --bind /lcg,/opt $SIF classifier.sh $VAR $SCRIPT_VAR
