#!/bin/bash
#FLUX: --job-name=3dTproject
#FLUX: --queue=all
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Purging modules"
module purge
module load afni
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running fMRIPrep on sub-$subj"
./run_glm.py $subj
echo "Finished running fMRIPrep on sub-$subj"
date
