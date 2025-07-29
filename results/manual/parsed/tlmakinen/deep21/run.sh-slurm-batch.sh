#!/bin/bash
#SBATCH --job-name=d21
#SBATCH --output=d21_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:v100-32gb:4
#SBATCH --mem=730gb
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --array=1-7

module load  gcc/7.4.0 cuda/10.1.243_418.87.00 cudnn/v7.6.2-cuda-10.1 nccl/2.4.2-cuda-10.1 python3/3.7.3
source ~/anaconda3/bin/activate tf_gpu
python3 train.py $SLURM_ARRAY_TASK_ID 
