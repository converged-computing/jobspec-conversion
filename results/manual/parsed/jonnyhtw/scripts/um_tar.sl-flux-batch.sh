#!/bin/bash
#FLUX: --job-name=um_tar
#FLUX: --queue=nesi_prepost
#FLUX: -t=86400
#FLUX: --priority=16

export suite='dc545'

export suite=dc545
cd /home/williamsjh/cylc-run/u-${suite}/runN/share/data/History_Data/
find . -maxdepth 1 -iname "*a.p${stream}${SLURM_ARRAY_TASK_ID}*" -exec tar --remove-files -rvf ${suite}a.p${stream}${SLURM_ARRAY_TASK_ID}.tar {} \; 
