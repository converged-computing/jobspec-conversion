#!/bin/bash
#FLUX: --job-name=placid-knife-3580
#FLUX: --urgency=16

cmd_line=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${1})
PYTHONPATH=./ $cmd_line
