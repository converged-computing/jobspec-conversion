#!/bin/bash
#SBATCH --output=<your_slurm_logging_path>/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=11GB
#SBATCH --array=0

hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
echo $SLURM_ARRAY_TASK_ID
