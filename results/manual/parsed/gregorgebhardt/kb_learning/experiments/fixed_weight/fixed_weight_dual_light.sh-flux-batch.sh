#!/bin/bash
#FLUX: --job-name=peachy-cinnamonbun-6983
#FLUX: --priority=16

export OMP_NUM_THREADS='8'

module purge
module load gcc openmpi/gcc/2.1
export OMP_NUM_THREADS=8
. /home/yy05vipo/bin/miniconda3/etc/profile.d/conda.sh
conda activate dme
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python fixed_weight/fixed_weight.py -c fixed_weight/fixed_weight.yml -e eval_dual_light -o
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
