#!/bin/bash
#FLUX: --job-name=cowy-taco-5972
#FLUX: --urgency=16

echo "In the directory: `pwd` "
echo "As the user: `whoami` "
echo "on host: `hostname` "
cat /proc/$$/status | grep Cpus_allowed_list
module load anacondapy/2020.11
. activate brainpipe
echo "Experiment name:" "`pwd`"
echo "Array Index: $SLURM_ARRAY_TASK_ID"
python cell_detect.py 3 ${SLURM_ARRAY_TASK_ID} "`pwd`" 
