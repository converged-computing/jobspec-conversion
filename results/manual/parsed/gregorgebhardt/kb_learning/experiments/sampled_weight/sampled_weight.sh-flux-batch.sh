#!/bin/bash
#FLUX: --job-name=stinky-puppy-8517
#FLUX: --urgency=16

source /home/yy05vipo/.virtenvs/gym/bin/activate
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python sampled_weight/sampled_weight.py -c sampled_weight/sampled_weight.yml --log_level INFO -e weight_bw
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
