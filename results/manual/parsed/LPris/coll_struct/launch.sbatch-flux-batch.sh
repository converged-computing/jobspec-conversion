#!/bin/bash
#FLUX: --job-name=struct_marl
#FLUX: -c=2
#FLUX: --queue=batch
#FLUX: -t=43200
#FLUX: --urgency=16

./run.sh $1 $2 $SLURM_ARRAY_TASK_ID
