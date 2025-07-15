#!/bin/bash
#FLUX: --job-name=crunchy-poodle-7901
#FLUX: --urgency=16

module purge
module load gcc/4.9.4 openmpi/gcc/2.1.2 python/3.6.2 intel/2018u1 boost/1.61
source /home/yy05vipo/.virtenvs/dme/bin/activate
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python ppo/ppo.py -c ppo/ppo.yml -e eval_num_kilobots
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
