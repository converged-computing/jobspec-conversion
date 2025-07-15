#!/bin/bash
#FLUX: --job-name="icml"
#FLUX: --queue=gpu-a100
#FLUX: -t=345600
#FLUX: --priority=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
source /usr/local/module/spartan_new.sh
module load gitpython/3.1.14
module load fosscuda/2020b
module load pytorch/1.10.0-python-3.8.6
MKL_THREADING_LAYER=GNU python3 experiments.py ${SLURM_ARRAY_TASK_ID}
