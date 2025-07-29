#!/bin/bash
#SBATCH --job-name=Bx_ll_sbatch_%A
#SBATCH --output=./data_midway/log_files/Bx190228CT3_%a.out
#SBATCH --error=./data_midway/log_files/Bx190228CT3_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16G
#SBATCH --partition=broadwl
#SBATCH --array=2-30

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load matlab/2014b
matlab -nojvm -nodisplay -nosplash -r "addpath(genpath('./')); midway_train_HMM_log_likelihood('./data/Bx190228CT3.mat',$SLURM_ARRAY_TASK_ID,4)"
