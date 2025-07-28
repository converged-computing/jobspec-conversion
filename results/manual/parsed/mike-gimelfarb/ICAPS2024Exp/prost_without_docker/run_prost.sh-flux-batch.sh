#!/bin/bash
#FLUX: --job-name=wobbly-plant-1705
#FLUX: -t=900
#FLUX: --urgency=16

source prost.sh $1 $SLURM_ARRAY_TASK_ID $3
