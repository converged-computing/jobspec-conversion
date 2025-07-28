#!/bin/bash
#FLUX: --job-name=deface
#FLUX: -c=8
#FLUX: --queue=all
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Purging modules"
module purge
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running pydeface on sub-$subj"
./deface.sh $subj
echo "Finished running pydeface on sub-$subj"
date
