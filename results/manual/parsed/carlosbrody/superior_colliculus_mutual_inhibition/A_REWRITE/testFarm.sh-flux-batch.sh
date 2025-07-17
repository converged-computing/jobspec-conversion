#!/bin/bash
#FLUX: --job-name=testFarm
#FLUX: --queue=Brody
#FLUX: -t=345600
#FLUX: --urgency=16

module load julia/1.2.0
echo "Slurm Job ID, unique: $SLURM_JOB_ID"
echo "Slurm Array Task ID, relative: $SLURM_ARRAY_TASK_ID"
arg1=$1
arg2=$2
shift
shift
sumofargs=$((arg1 + arg2))
echo "sum of args is $sumofargs"
echo "other args are $@"
