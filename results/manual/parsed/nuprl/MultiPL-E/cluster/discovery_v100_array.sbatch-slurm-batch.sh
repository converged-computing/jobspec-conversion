#!/bin/bash
#SBATCH --job-name=v100-arrayjob
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --mem=40G
#SBATCH --time=08:00:00

JOB_FILE=$1
EXTRA_ARGS=${@:2}
JOB=`sed -n ${SLURM_ARRAY_TASK_ID}p ${JOB_FILE}`
hostname
echo $JOB $EXTRA_ARGS
bash -c "$JOB $EXTRA_ARGS"
