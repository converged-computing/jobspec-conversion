#!/bin/bash
#FLUX: --job-name=hello-diablo-4187
#FLUX: -t=900
#FLUX: --priority=16

source prost.sh $1 $SLURM_ARRAY_TASK_ID $3
