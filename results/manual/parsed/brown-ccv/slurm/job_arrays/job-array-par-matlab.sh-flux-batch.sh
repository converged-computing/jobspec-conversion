#!/bin/bash
#FLUX: --job-name=wobbly-fork-8951
#FLUX: -c=2
#FLUX: -t=300
#FLUX: --urgency=16

module load matlab/R2021a 
tmpdir=~/matlab_temp_dir/$SLURM_ARRAY_TASK_ID
mkdir -p $tmpdir
matlab-threaded -nodisplay -r "multi_parfor('$tmpdir', $SLURM_ARRAY_TASK_ID), exit"
rm -r $tmpdir
