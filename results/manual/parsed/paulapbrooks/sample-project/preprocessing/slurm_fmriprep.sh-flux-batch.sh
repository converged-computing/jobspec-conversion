#!/bin/bash
#FLUX: --job-name=fmriprep
#FLUX: -c=8
#FLUX: --queue=all
#FLUX: --urgency=16

echo "Purging modules"
module purge
echo "Slurm job ID: " $SLURM_JOB_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running fMRIPrep on sub-$subj"
./run_fmriprep.sh $subj
echo "Finished running fMRIPrep on sub-$subj"
date
echo "Defacing preprocessed T1w for sub-$subj"
./deface_template.sh $subj
echo "Finished defacing T1w"
