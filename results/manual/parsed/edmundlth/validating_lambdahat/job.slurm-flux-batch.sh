#!/bin/bash
#FLUX: --job-name=lambdahat
#FLUX: -c=2
#FLUX: --queue=gpu-a100,gpu-a100-short,gpu-a100-preempt
#FLUX: -t=7200
#FLUX: --priority=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
module load Python/3.10.4
source /home/elau1/venvgpu3.10/bin/activate
CMD=$(sed -n "${SLURM_ARRAY_TASK_ID}p" commands_random_truth.txt)
echo "Executing command: $CMD"
eval $CMD
deactivate
my-job-stats -a -n -s
