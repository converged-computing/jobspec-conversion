#!/bin/bash
#FLUX: --job-name=ppo_relative_w
#FLUX: -n=9
#FLUX: -c=8
#FLUX: -t=21600
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'

module purge
module load gcc openmpi/gcc/2.1
export OMP_NUM_THREADS=8
. /home/yy05vipo/bin/miniconda3/etc/profile.d/conda.sh
conda activate dme
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python ppo/ppo.py -c ppo/ppo.yml -e eval_relative_env
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
