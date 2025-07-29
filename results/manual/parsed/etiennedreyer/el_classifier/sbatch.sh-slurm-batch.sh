#!/bin/bash
#SBATCH --job-name=el-id
#SBATCH --account=def-arguinj
#SBATCH --output=outputs/log_files/%x_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --time=00:03:00
#SBATCH --array=0

export VAR='$SLURM_ARRAY_TASK_ID'

export VAR=$SLURM_ARRAY_TASK_ID
export SCRIPT_VAR
SIF=/opt/tmp/godin/sing_images/tf-2.1.0-gpu-py3_sing-2.6.sif
singularity shell --nv --bind /lcg,/opt $SIF classifier.sh $VAR $SCRIPT_VAR
