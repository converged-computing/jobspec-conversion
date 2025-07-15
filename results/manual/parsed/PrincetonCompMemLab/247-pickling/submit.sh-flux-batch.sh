#!/bin/bash
#FLUX: --job-name=persnickety-lemon-6876
#FLUX: -c=4
#FLUX: -t=10800
#FLUX: --priority=16

if [[ "$HOSTNAME" == *"tiger"* ]]
then
    echo "It's tiger"
    module load anaconda
    source activate torch-env
else
    module load anacondapy
    source activate srm
fi
echo 'Requester:' $USER
echo 'Node:' $HOSTNAME
echo 'Start time:' `date`
echo "$@"
if [[ -v SLURM_ARRAY_TASK_ID ]]
then
    python "$@" --conversation-id $SLURM_ARRAY_TASK_ID
else
    python "$@"
fi
echo 'End time:' `date`
