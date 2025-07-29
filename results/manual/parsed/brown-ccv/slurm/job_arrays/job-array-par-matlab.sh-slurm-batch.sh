#!/bin/bash
#SBATCH --job-name=arrayjob-matlab
#SBATCH --output=%x-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-4

module load matlab/R2021a 
tmpdir=~/matlab_temp_dir/$SLURM_ARRAY_TASK_ID
mkdir -p $tmpdir
matlab-threaded -nodisplay -r "multi_parfor('$tmpdir', $SLURM_ARRAY_TASK_ID), exit"
rm -r $tmpdir
