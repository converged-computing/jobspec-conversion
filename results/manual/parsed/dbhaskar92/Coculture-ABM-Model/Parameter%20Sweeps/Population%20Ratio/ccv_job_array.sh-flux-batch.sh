#!/bin/bash
#FLUX: --job-name=frigid-lemur-0869
#FLUX: --priority=16

echo "Starting job $SLURM_ARRAY_TASK_ID on $HOSTNAME"
matlab-threaded -nodisplay -r "coculture_model($SLURM_ARRAY_TASK_ID); exit"
