#!/bin/bash
#SBATCH --job-name=gan
#SBATCH --output=job_outputs_%A_%a.out
#SBATCH --error=job_errors_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=16g
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-100

module load python
python /home/ImageGen/trainGAN_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/generateGAN_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/evaluation/evaluate_training_gan_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/evaluation/evaluate_training_unscaled_gan_seed.py $SLURM_ARRAY_TASK_ID
