#!/bin/bash
#FLUX: --job-name=psycho-house-2685
#FLUX: --queue=node
#FLUX: -t=60
#FLUX: --urgency=16

python comp_con_attributes_array3.py "${SLURM_ARRAY_TASK_ID}"
