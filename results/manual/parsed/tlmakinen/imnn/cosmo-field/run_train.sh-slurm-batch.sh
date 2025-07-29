#!/bin/bash
#SBATCH --job-name=field_imnn
#SBATCH --output=./slurmscripts/job_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100-32gb:1
#SBATCH --mem=730gb
#SBATCH --time=03:00:00
#SBATCH --partition=gpu
#SBATCH --array=1-4

module load  gcc/7.4.0 cuda/10.1.243_418.87.00 cudnn/v7.6.2-cuda-10.1 nccl/2.4.2-cuda-10.1 python3/3.7.3
source ~/anaconda3/bin/activate pyimnn
python3 field_run.py $SLURM_ARRAY_TASK_ID 
