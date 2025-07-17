#!/bin/bash
#FLUX: --job-name=lovely-itch-9673
#FLUX: -c=10
#FLUX: --queue=all
#FLUX: -t=1200
#FLUX: --urgency=16

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
