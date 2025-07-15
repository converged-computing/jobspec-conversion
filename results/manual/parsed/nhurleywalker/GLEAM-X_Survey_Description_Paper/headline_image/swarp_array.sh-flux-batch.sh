#!/bin/bash
#FLUX: --job-name=peachy-lettuce-5182
#FLUX: --queue=workq
#FLUX: -t=1200
#FLUX: --urgency=16

file=`ls IDR1_XG*fits | head -${SLURM_ARRAY_TASK_ID} | tail -1`
singularity exec $GXCONTAINER swarp -c CAR.swarp.template $file
