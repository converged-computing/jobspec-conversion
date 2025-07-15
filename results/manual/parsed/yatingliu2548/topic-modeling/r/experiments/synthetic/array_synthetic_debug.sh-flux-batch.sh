#!/bin/bash
#FLUX: --job-name=array
#FLUX: -n=5
#FLUX: --queue=amd
#FLUX: -t=126000
#FLUX: --priority=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "My SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
job_id=$SLURM_ARRAY_JOB_ID
module load gsl
module load R/4.2.0
module load matlab
module load python
MATLAB_PATH="/software/matlab-2023a-el8-x86_64/bin/matlab"
result_file="testing_p_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
echo "result file is ${result_file}"
cd $SCRATCH/$USER/topic-modeling/
Rscript r/experiments/synthetic/synthetic_experiment.R $SLURM_ARRAY_TASK_ID $result_file $1 $MATLAB_PATH $2 $3 # 5 topic
