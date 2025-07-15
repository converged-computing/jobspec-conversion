#!/bin/bash
#FLUX: --job-name=sweep_job
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --priority=16

USERDIR=/home/jc11431
module purge
module load anaconda3/2020.07
source ~/.bashrc
conda activate $USERDIR/.conda/envs/metaicl-a100
myquota
nvidia-smi
which python
wandb login
sweep_path=$1
cd $USERDIR/git/MetaICL
echo SLURM_JOBID $SLURM_JOBID
echo SLURM_ARRAY_JOB_ID $SLURM_ARRAY_JOB_ID
echo SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID
wandb agent --count 1 $sweep_path
