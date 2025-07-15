#!/bin/bash
#FLUX: --job-name="permutations-transformer-training"
#FLUX: --queue=gpu-a100
#FLUX: -t=259200
#FLUX: --priority=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
source ./venv/bin/activate
python ./main.py
my-job-stats -a -n -s
