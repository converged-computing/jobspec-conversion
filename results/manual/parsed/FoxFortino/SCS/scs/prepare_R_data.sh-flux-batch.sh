#!/bin/bash
#FLUX: --job-name=prepare_R_data
#FLUX: -c=2
#FLUX: --queue=idle
#FLUX: -t=604800
#FLUX: --priority=16

UD_QUIET_JOB_SETUP=YES
echo "SLURM ARRAY TASK ID: $SLURM_ARRAY_TASK_ID"
echo "SLURM RESTART COUNT: $SLURM_RESTART_COUNT"
python /home/2649/repos/SCS/scs/prepare_R_data.py --R=$SLURM_ARRAY_TASK_ID
