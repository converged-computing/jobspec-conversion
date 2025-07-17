#!/bin/bash
#FLUX: --job-name=bricky-eagle-8010
#FLUX: --queue=workq
#FLUX: -t=1200
#FLUX: --urgency=16

file=`ls IDR1_XG*fits | head -${SLURM_ARRAY_TASK_ID} | tail -1`
singularity exec $GXCONTAINER swarp -c CAR.swarp.template $file
