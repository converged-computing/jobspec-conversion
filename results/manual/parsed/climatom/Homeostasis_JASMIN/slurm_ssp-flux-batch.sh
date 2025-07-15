#!/bin/bash
#FLUX: --job-name=ssp_home
#FLUX: --queue=short-serial
#FLUX: -t=21600
#FLUX: --priority=16

module add jaspy
cd /home/users/tommatthews/Homeostasis/
source /home/users/tommatthews/Homeostasis/xheat/bin/activate
python compute_ssp.py ${SLURM_ARRAY_TASK_ID}
