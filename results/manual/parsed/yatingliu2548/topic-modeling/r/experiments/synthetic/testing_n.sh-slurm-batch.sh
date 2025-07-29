#!/bin/bash
#SBATCH --job-name=array
#SBATCH --account=pi-cdonnat
#SBATCH --output=r/experiments/synthetic/logs/array_%A_%a.out
#SBATCH --error=r/experiments/synthetic/logs/array_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=1-11:00:00
#SBATCH --partition=amd
#SBATCH --array=1-50

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "My SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
job_id=$SLURM_ARRAY_JOB_ID
module load gsl
module load gcc
module load aocc
module load R/4.2.0
module load matlab
module load python
MATLAB_PATH="/software/matlab-2023a-el8-x86_64/bin/matlab"
result_file="testing_n_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
echo "result file is ${result_file}"
cd $SCRATCH/$USER/topic-modeling/
Rscript r/experiments/synthetic/testing_n.R $SLURM_ARRAY_TASK_ID $result_file $1 $2 $3 $4 $5 # 5 topic
