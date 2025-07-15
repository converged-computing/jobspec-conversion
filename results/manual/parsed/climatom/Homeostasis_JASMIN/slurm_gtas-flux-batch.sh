#!/bin/bash
#FLUX: --job-name=gtas_home
#FLUX: --queue=short-serial
#FLUX: -t=1800
#FLUX: --urgency=16

module add jaspy
cd /home/users/tommatthews/Homeostasis/
bash glob_mean.sh ${SLURM_ARRAY_TASK_ID}
