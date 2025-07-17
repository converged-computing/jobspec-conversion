#!/bin/bash
#FLUX: --job-name=rdkitconf
#FLUX: --queue=kemi1
#FLUX: -t=86400
#FLUX: --urgency=16

WIDTH=1000
TMP=`expr $SLURM_ARRAY_TASK_ID - 1`
TMP2=`expr $TMP \* $WIDTH`
IDFROM=`expr $TMP2 + 1`
python smi2sdf.py input.smi -i ${IDFROM} -w ${WIDTH}
