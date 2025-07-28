#!/bin/bash
#FLUX: --job-name=hist_home
#FLUX: --queue=short-serial
#FLUX: -t=21600
#FLUX: --urgency=16

module add jaspy
cd /home/users/tommatthews/Homeostasis/
source /home/users/tommatthews/Homeostasis/xheat/bin/activate
python compute_hist.py ${SLURM_ARRAY_TASK_ID}
