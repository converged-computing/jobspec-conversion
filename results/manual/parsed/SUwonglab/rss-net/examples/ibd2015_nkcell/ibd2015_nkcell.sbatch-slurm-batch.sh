#!/bin/bash
#SBATCH --job-name=ibd2015_nkcell
#SBATCH --output=/scratch/users/xiangzhu/dump/ibd2015_nkcell_%A_%a.out
#SBATCH --error=/scratch/users/xiangzhu/dump/ibd2015_nkcell_%A_%a.err
#SBATCH --mail-user=xiangzhu.nku@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32000
#SBATCH --time=12:30:00
#SBATCH --partition=hns,owners,normal,whwong
#SBATCH --constraint=ntasks-per-node=8
#SBATCH --array=1-125

module unload matlab
module load matlab/R2017b
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
cp ibd2015_nkcell.m case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
echo "case_id = $SLURM_ARRAY_TASK_ID;" | cat - case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m > temp_"$SLURM_ARRAY_TASK_ID"_run_analysis.m && mv temp_"$SLURM_ARRAY_TASK_ID"_run_analysis.m case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
echo "clear;" | cat - case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m > temp_"$SLURM_ARRAY_TASK_ID"_run_analysis.m && mv temp_"$SLURM_ARRAY_TASK_ID"_run_analysis.m case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
matlab -nodisplay < case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
rm case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
