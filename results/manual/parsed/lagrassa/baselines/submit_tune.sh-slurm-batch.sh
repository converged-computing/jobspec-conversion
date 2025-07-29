#!/bin/bash
#SBATCH --output=tune_fp.out-%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --constraint=opteron
#SBATCH --array=1-1

export CUDA_VISIBLE_DEVICES=''

source /etc/profile
module load cuda-9.0
export CUDA_VISIBLE_DEVICES=""
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
python tune.py naf_fetchpush
