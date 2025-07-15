#!/bin/bash
#FLUX: --job-name=phat-peas-7171
#FLUX: --priority=16

echo "In the directory: `pwd` "
echo "As the user: `whoami` "
echo "on host: `hostname` "
cat /proc/$$/status | grep Cpus_allowed_list
echo "Array Allocation Number: $SLURM_ARRAY_JOB_ID"
echo "Array Index: $SLURM_ARRAY_TASK_ID"
module load anacondapy/2020.11
module load elastix/4.8
. activate brainpipe
xvfb-run -d python main.py 2 ${SLURM_ARRAY_TASK_ID} #combine stacks into single tifffiles
