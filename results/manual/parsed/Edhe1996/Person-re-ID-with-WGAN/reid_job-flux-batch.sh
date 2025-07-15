#!/bin/bash
#FLUX: --job-name=label
#FLUX: --queue=gpu
#FLUX: -t=900
#FLUX: --priority=16

module load CUDA
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Slurm job ID is $SLURM_JOB_ID
echo This job runs on the following machines:
echo `echo $SLURM_JOB_NODELIST | uniq`
python ./assign_label.py
