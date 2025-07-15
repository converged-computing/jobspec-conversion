#!/bin/bash
#FLUX: --job-name=matching
#FLUX: --queue=cpu
#FLUX: -t=28800
#FLUX: --priority=16

python appli_prevalent.py ${SLURM_ARRAY_TASK_ID}
