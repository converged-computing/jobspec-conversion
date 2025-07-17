#!/bin/bash
#FLUX: --job-name=fmriprep
#FLUX: -c=4
#FLUX: --queue=all
#FLUX: -t=57600
#FLUX: --urgency=16

echo "Purging modules"
module purge
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running fMRIPrep on sub-$subj"
./run_fmriprep.sh $subj
echo "Finished running fMRIPrep on sub-$subj"
date
