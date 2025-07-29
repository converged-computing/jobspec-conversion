#!/bin/bash
#FLUX: --job-name=smoothing
#FLUX: -c=2
#FLUX: --queue=all
#FLUX: -t=28800
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
echo "Running spatial smoothing on sub-$subj"
./run_smoothing.py $subj MNI152NLin2009cAsym 6
./run_smoothing.py $subj fsaverage6 6
echo "Finished spatially smoothing sub-$subj"
date
