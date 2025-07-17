#!/bin/bash
#FLUX: --job-name=gl_eval_height
#FLUX: -n=24
#FLUX: -c=8
#FLUX: -t=18000
#FLUX: --urgency=16

source /home/yy05vipo/.virtenvs/gym/bin/activate
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python gradient_light/gradient_light.py -c gradient_light/gradient_light.yml --log_level INFO -e eval_height
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
