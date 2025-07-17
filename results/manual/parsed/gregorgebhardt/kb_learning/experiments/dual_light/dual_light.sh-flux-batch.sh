#!/bin/bash
#FLUX: --job-name=dual_light
#FLUX: -n=3
#FLUX: -c=8
#FLUX: -t=10800
#FLUX: --urgency=16

source /home/yy05vipo/.virtenvs/gym/bin/activate
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python dual_light/dual_light.py -c dual_light/dual_light.yml --log_level INFO -e test -o
