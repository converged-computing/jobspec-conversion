#!/bin/bash
#SBATCH --job-name=train_model
#SBATCH --account=
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

module load pytorch
srun python train_model.py config/deuce/deuce default --model bcnn --data fmi --callback ensemble &> train_model.out
seff $SLURM_JOBID
