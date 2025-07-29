#!/bin/bash
#SBATCH --job-name=array
#SBATCH --account=pi-cdonnat
#SBATCH --output=experiments/logs/array_%A_%a.out
#SBATCH --error=experiments/logs/array_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=1-11:00:00
#SBATCH --partition=broadwl
#SBATCH --array=1-20

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "My SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
job_id=$SLURM_ARRAY_JOB_ID
module load R/4.2.0
module load matlab
echo $1
echo $2
id_experiment="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
name_experiment="$3-$1-$2-$4-${id_experiment}"
echo "name experiment is ${name_experiment}"
cd $SCRATCH/topic_modeling/r/
Rscript experiments/synthetic_AP.R ${id_experiments}
