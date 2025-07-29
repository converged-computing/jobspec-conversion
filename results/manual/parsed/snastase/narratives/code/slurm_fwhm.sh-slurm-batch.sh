#!/bin/bash
#FLUX: --job-name=3dFWHMx
#FLUX: --queue=all
#FLUX: -t=14400
#FLUX: --urgency=16

echo "Purging modules"
module purge
echo "Loading AFNI module afni/2019.10.09"
module load afni/2019.10.09
afni --version
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running spatial smoothing estimate for sub-$subj"
./get_fwhm.py $subj
echo "Finished smoothing estimate for sub-$subj"
date
