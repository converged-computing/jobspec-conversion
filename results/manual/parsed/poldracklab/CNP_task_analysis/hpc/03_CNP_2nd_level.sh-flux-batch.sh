#!/bin/bash
#FLUX --job-name=wobbly-rabbit-4607
#FLUX --queue=hns,normal
#FLUX -t=36000
#FLUX --urgency=16

source $HOME/CNP_analysis/config.sh
unset PYTHONPATH
if [ ! -f $SINGULARITY ]; then
    echo "Singularity container for analyses not found!  Please first create singularity container."
fi
singularity exec $SINGULARITY echo "Analyis '${SLURM_ARRAY_TASK_ID}' started"
cd $HOMEDIR
set -e
eval $( sed "${SLURM_ARRAY_TASK_ID}q;d" $HOMEDIR/hpc/group_tasks.txt )
echo "༼ つ ◕_◕ ༽つ CNP modeling pipeline finished"
