#!/bin/bash
#FLUX: --job-name=chunky-soup-7624
#FLUX: -t=14400
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load conda/py2-latest
COUNT=$SLURM_ARRAY_TASK_ID
DIREC=$(sed ''$COUNT'q;d' parts)
while read l; do sh GENEPY_1.3.sh $l; done<$DIREC
