#!/bin/bash
#SBATCH --job-name=PredictTemple1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=neuro-hsc
#SBATCH --array=1

module load matlab/R2022a
cd /carc/scratch/projects/mckenzie2016183/code/matlab
matlab -singleCompThread -nodisplay  -nodesktop  -nojvm -r "sm_PredictTemple_getAllFeatures_CARC($SLURM_ARRAY_TASK_ID); exit;"
