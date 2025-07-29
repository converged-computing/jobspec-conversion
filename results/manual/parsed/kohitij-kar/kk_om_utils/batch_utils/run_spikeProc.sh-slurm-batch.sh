#!/bin/bash
#SBATCH --job-name=spk_proc
#SBATCH --output=slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=10:00:00
#SBATCH --array=0-256

matlab -nodesktop -nosplash -r "cd('/home/kohitij/kk_om_utils'); addpath(genpath(pwd)); date = '170522'; runGetTrialTimes('num','$SLURM_ARRAY_TASK_ID','date',date); runSpikeDetection('date',date,'num','$SLURM_ARRAY_TASK_ID'); runGetPSTH('num','$SLURM_ARRAY_TASK_ID','date',date); exit"
