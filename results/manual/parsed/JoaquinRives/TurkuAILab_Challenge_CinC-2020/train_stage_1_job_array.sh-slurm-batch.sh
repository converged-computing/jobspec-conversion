#!/bin/bash
#SBATCH --job-name=002
#SBATCH --account=Project_2002932
#SBATCH --output=array_job_out_%A_%a.out
#SBATCH --error=array_job_err_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=8000
#SBATCH --time=2-20:00:00
#SBATCH --array=1-4

module load tensorflow/1.14.0 gcc/8.3.0 cuda/10.1.168
list_args="model_1_1 model_1_2 model_1_3 model_1_4"
arr=($list_args)
srun python train_stage_1.py ${arr[${SLURM_ARRAY_TASK_ID} - 1]}
