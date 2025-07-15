#!/bin/bash
#FLUX: --job-name=Bx_ll_sbatch_%A
#FLUX: -n=4
#FLUX: --queue=broadwl
#FLUX: --priority=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load matlab/2014b
matlab -nojvm -nodisplay -nosplash -r "addpath(genpath('./')); midway_train_HMM_log_likelihood('./data/Bx190228CT3.mat',$SLURM_ARRAY_TASK_ID,4)"
