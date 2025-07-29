#!/bin/bash
#FLUX --job-name=astute-blackbean-0577
#FLUX -c=6
#FLUX --queue=rtx6000
#FLUX --urgency=16

cmd_line=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${1})
PYTHONPATH=./ $cmd_line
