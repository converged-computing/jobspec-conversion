#!/bin/bash
#FLUX: --job-name=3feature_files
#FLUX: --queue=node
#FLUX: -t=360
#FLUX: --urgency=16

python comp_con_attributes_array3.py "${SLURM_ARRAY_TASK_ID}"
