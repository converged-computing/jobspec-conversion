#!/bin/bash
#FLUX: --job-name=carnivorous-butter-2357
#FLUX: --priority=16

source /home/yy05vipo/.virtenvs/gym/bin/activate
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python dual_light/dual_light.py -c dual_light/dual_light.yml --log_level INFO -e test -o
