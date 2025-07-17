#!/bin/bash
#FLUX: --job-name=ACAEtest
#FLUX: --queue=gpu
#FLUX: -t=720
#FLUX: --urgency=16

export FP='jobresult_$SLURM_JOB_ID'

export FP="jobresult_$SLURM_JOB_ID"
mkdir $FP
module load gcc/6.2.0 python/3.6.0 cuda/10.0
source /home/hw233/virtualenv/py3/bin/activate
python test_train_MNIST.py
mv "joboutput_$SLURM_JOB_ID.out" "$FP/job.out"
mv "joberror_$SLURM_JOB_ID.err" "$FP/job.err"
