#!/bin/bash
#FLUX: --job-name=thefinal_optfl_dense
#FLUX: -c=128
#FLUX: --urgency=16

export SLURM_CPU_BIND='none'

date
hostname
export SLURM_CPU_BIND=none
HOSTFILE=$(pwd)/hostfile
source $(pwd)/../optfl_env/bin/activate
EOF
source $(pwd)/../optfl_env/bin/activate
scontrol show hostnames > $HOSTFILE
INPUTFILE=$(pwd)/src/nsga2.py 
python -m scoop --hostfile $HOSTFILE -n 100 $INPUTFILE $SLURM_ARRAY_TASK_ID "DENSE" 4 $@
