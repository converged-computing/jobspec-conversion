#!/bin/bash
#FLUX: --job-name=chunky-poo-1497
#FLUX: --urgency=16

echo "Starting job $SLURM_ARRAY_TASK_ID on $HOSTNAME"
matlab-threaded -nodisplay -r "coculture_model($SLURM_ARRAY_TASK_ID); exit"
