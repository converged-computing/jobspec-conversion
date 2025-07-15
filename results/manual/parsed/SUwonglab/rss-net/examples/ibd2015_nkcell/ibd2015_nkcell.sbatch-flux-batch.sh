#!/bin/bash
#FLUX: --job-name=ibd2015_nkcell
#FLUX: --queue=hns,owners,normal,whwong
#FLUX: -t=45000
#FLUX: --priority=16

module unload matlab
module load matlab/R2017b
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
cp ibd2015_nkcell.m case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
echo "case_id = $SLURM_ARRAY_TASK_ID;" | cat - case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m > temp_"$SLURM_ARRAY_TASK_ID"_run_analysis.m && mv temp_"$SLURM_ARRAY_TASK_ID"_run_analysis.m case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
echo "clear;" | cat - case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m > temp_"$SLURM_ARRAY_TASK_ID"_run_analysis.m && mv temp_"$SLURM_ARRAY_TASK_ID"_run_analysis.m case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
matlab -nodisplay < case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
rm case_"$SLURM_ARRAY_TASK_ID"_run_analysis.m
