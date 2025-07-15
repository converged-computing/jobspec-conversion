#!/bin/bash
#FLUX: --job-name="permutations-transformer-testing"
#FLUX: --queue=gpu-a100-short
#FLUX: -t=7200
#FLUX: --priority=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
source ./venv/bin/activate
python ./testing.py
my-job-stats -a -n -s
